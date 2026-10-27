# ZKP Reports

Reports and drafts written during the Innosuisse grant 101.292 IP-ICT -
_Secure and Privacy-Preserving Credentials for E-ID_ - between EPFL and SICPA SA.

| Directory                                                    | Content                                                                                                           | Format | DOI |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ------ | --- |
| [ms2-report](ms2-report/)                                    | Milestone 2 report: proof-of-concept, comparison of ZKP stacks                                                    | typst  | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23694201.svg)](https://doi.org/10.5281/zenodo.23694201) |
| [ms4-report](ms4-report/)                                    | Final report of the grant                                                                                         | typst  | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23694203.svg)](https://doi.org/10.5281/zenodo.23694203) |
| [taxonomy-eid](taxonomy-eid/)                                | Taxonomy of the Swiss and EU e-ID systems (draft paper)                                                           | LaTeX  | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23694217.svg)](https://doi.org/10.5281/zenodo.23694217) |
| [security-review](security-review/zksecurity-epfl-sicpa.pdf) | External security review of the circuits and the Spartan prover by [zkSecurity](https://zksecurity.xyz/), 2026-10 | PDF    |     |

Every push to `main` builds the typst and LaTeX PDFs and publishes them in the
[releases](https://github.com/eid-privacy/zkp-reports/releases).
The latest versions are always in the
[latest](https://github.com/eid-privacy/zkp-reports/releases/tag/latest) release.

## Building locally

With [DevBox](https://www.jetify.com/docs/devbox/installing-devbox) installed:

```bash
devbox run compile    # all reports
devbox run ms2        # ms2-report/eid-privacy-MS2.pdf
devbox run ms4        # ms4-report/eid-privacy-MS4.pdf
devbox run taxonomy   # taxonomy-eid/eid-privacy-taxonomy-eid.pdf
```

## How to cite

The MS2 and MS4 reports and the taxonomy draft are archived on Zenodo, in the
[eid-privacy community](https://zenodo.org/communities/eid-privacy).
The DOIs below always resolve to the latest version.

```bibtex
@techreport{eid-privacy-ms4,
  author      = {Dengler, Carine and Humbert, Clément and Gasser, Linus},
  title       = {Secure and Privacy-Preserving Credentials for E-ID - Final Report},
  institution = {EPFL and SICPA},
  type        = {Innosuisse grant 101.292 IP-ICT report},
  year        = {2026},
  doi         = {10.5281/zenodo.23694203},
}

@techreport{eid-privacy-ms2,
  author      = {Gasser, Linus and Humbert, Clément and Elghareeb, Ahmed},
  title       = {Secure and Privacy-Preserving Credentials for E-ID - Proof-of-Concept},
  institution = {EPFL and SICPA},
  type        = {Innosuisse grant 101.292 IP-ICT report},
  year        = {2026},
  doi         = {10.5281/zenodo.23694201},
}

@misc{eid-privacy-taxonomy,
  author = {Gasser, Linus and Humbert, Clément and Elghareeb, Ahmed},
  title  = {Taxonomy for Privacy-Preserving Electronic Identities},
  note   = {Preprint},
  year   = {2025},
  doi    = {10.5281/zenodo.23694217},
}
```

### Uploading a new version

`zenodo/<doc>.json` holds the metadata of each record. To create a draft
from the PDF in the `latest` release (publish it on Zenodo afterwards):

```bash
export ZENODO_TOKEN=...           # scopes deposit:write, deposit:actions
devbox run upload taxonomy 23694218   # new version of the taxonomy record
devbox run upload <doc>               # new record
```

Update `version` and `publication_date` in `zenodo/<doc>.json` first.
Set `ZENODO_URL=https://sandbox.zenodo.org` to test (needs a sandbox token).

## History

The reports were copied from their original repositories, which hold the
full history:
[MS2-Minimal-Viable-Project](https://github.com/eid-privacy/MS2-Minimal-Viable-Project),
[MS4-Implementation-Report](https://github.com/eid-privacy/MS4-Implementation-Report),
[taxonomy-eid](https://github.com/eid-privacy/taxonomy-eid).

## License

[CC BY-SA 4.0](LICENSE), except for the security review in
[security-review](security-review/), which was written by zkSecurity.
