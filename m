Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020D63A4EA5
	for <lists+dmaengine@lfdr.de>; Sat, 12 Jun 2021 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFLM2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Jun 2021 08:28:16 -0400
Received: from mail-eopbgr1410120.outbound.protection.outlook.com ([40.107.141.120]:14573
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230191AbhFLM2P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 12 Jun 2021 08:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9dsEVKHgOxa/fX3MoEX68or/EKMZcTNYBslqxnf+dcF+VJPbi3EvaNWLNqDUnsOC4DYjH4c2hFN8CeBcFkEKSwH9P809COZ8SDiDK6qpZMUgbRnYXkFlzN1GFjNGaGH2Mtd2ZvVNioYqy2LROjT5WT+Zp6HAV+6Tt+wVG1Y/8o8pEb+hFOYC86lMxMdzRL60+Y+1BOvDfMKzOy1iCWAcnsY7hdUKPCpdzWqAqdz4pmIid6VXC9ZagHZzjrrakDFwjxV27YcjEzsyiUX372XFWYBE/tU2HyaV8SK2p2lNWNo1tNePFflqIkYgolCmuZ/LVNg20CX5Oz5zl2Rq1N/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+SEQm+St0GiPBOrM0YF6DW72KIOb4GxeBonrLIxBP4=;
 b=etLuQ0ARZtjnOa7u3Y41VRuR6dj4fMGLdGFZ+D1xu82cv04fbXekVHZxJm96izIQXTZhKS4WersecRTIYBnVPgB0HhaAc/0ddpCxqYY15Q0kTKgcVn43hv2CdmCL7003LRsoMe8EnJUQG9gUq5cfUweVkW8yvf8n0dURB4jnC5n9Zuxo9Sa0REizCmWmUzYImTMNTK8fHNkoNqzqUY7H/IEJEOuE8iZJIoOXHtf/lG4QaonymQBCJmvMWrikfIrgBB00nY3Tn+tB3pG5NUTXrs6SdOF7+qvmOB46AGuOctqc6t1qjz0IcAzgQIIw2/qR4xVL1ajTrMApDg6nyqNNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+SEQm+St0GiPBOrM0YF6DW72KIOb4GxeBonrLIxBP4=;
 b=EJDrJiroWgfcZ7VwhDfttk6oWy1uLoWvMlvguX85NmSgSCRwVCx/emjeFifs6vQr4HZdv+LOVePRgWX6j2K4XhG6wqHdHofXFh5rSnAE8ZwUf+6wEmAr+uhvVIp7qlHLf2KHyeQ760qfvvH7NN/kgg9rzu1HdZAyFy5QvpHw+Lw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5686.jpnprd01.prod.outlook.com (2603:1096:604:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Sat, 12 Jun
 2021 12:26:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4219.024; Sat, 12 Jun 2021
 12:26:13 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXXrYS1Y35K9bUV02GRKgFCWvED6sPNYEAgAEXDeA=
Date:   Sat, 12 Jun 2021 12:26:13 +0000
Message-ID: <OS0PR01MB5922D52151C1FCC29014003186339@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
 <20210611193916.GA1254227@robh.at.kernel.org>
In-Reply-To: <20210611193916.GA1254227@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [86.139.26.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ded4835-e0fd-4dfa-245c-08d92d9d44c6
x-ms-traffictypediagnostic: OS3PR01MB5686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB5686608B74F0AB145F1035DB86339@OS3PR01MB5686.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHjOYI76eNlkcaTVBImGhWLnvMyLYcT0+kEZgstXux6AhJmxBMoIDJi98urOTuGoIjMPwNUiWpEGcUC3/rs9jzsy2+JTfDq20ep2PxqhszMTi2+cqapgW/lHiZvamIab3Lcm/3IpVVYd7b7ovO8rWV3wIh2kiXh4rsC6bkcbxakW8sXKMs3XrR+6aBwu70YaBecpb+n+Oy+zdUdsfq8vxOAYKt0qXJ+ocZ/87n6X9Q1SHJeK38KuYt44cH0DLDq2Kfa0XpVvUPU1ysakifnD4XTulF7tJHE926aNau3Q2v3WV4XSDOIaXqa4n57472xTuG0rlr1evnC1iTg+bAPIzcPhO7ivCZKxr4L+AxkqdYaKaPiHHNLM7vNvPmKelYpXXr+B+HiP+5tWrvN5TrQYjWdwEYxJIjFZoIF1g6ctWBiWtnLyVmOXLA3npPAxC1ailWyBR269XOHzgtkh+Xp5aTXM/Ml2jyfK/gsW7QQ3e6xcZWjnKXbbNW9nN1Mf/f8d3uasUKZBtTZK1I52n25/JKOZYyLjWCEaHqQlmkG9BjV1xjQb+uOZ1ADhPc5gm8L5OHDFH0rF5igI9yDZY5p/FG95FXnzsqx+VCmfxG/SSz6+QoJz4SAV8HOxWyCRGrACS9a6L9b34BEgch5A6uMfHGgH0y8Pih/ht4Si3iteG4SCd4nKGep46NqbL9GhcjD3YGecMi5HcaGHTKr0j9mC+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39830400003)(396003)(376002)(52536014)(45080400002)(478600001)(9686003)(7696005)(316002)(4326008)(5660300002)(55016002)(66946007)(186003)(122000001)(33656002)(2906002)(38100700002)(6916009)(8676002)(71200400001)(76116006)(6506007)(54906003)(64756008)(66476007)(83380400001)(66446008)(86362001)(8936002)(66556008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0VjLyziIyNRcamdP98FmsGg2iapnyfaN32nImXNW6jd5UWaPh7xW5vFVcAX/?=
 =?us-ascii?Q?fuL1uu3qMRfD0S3W1J5GOQZIN1/D0cRR1Bu8q3romjUFImgEtpnM/wRm/yHp?=
 =?us-ascii?Q?lDwczmrIlHEBvffX/QSg1Srp+bpt9k7HKhFF4gnY9GjjGgaimaVJB3ys4UPA?=
 =?us-ascii?Q?UE7s7MpYI0GTGvBGpiLJKlDLuxfcFh6MJsjM3liO6vDrMGjje1hYfqoiSgcZ?=
 =?us-ascii?Q?EJtwvM83Mmhu0Cxp06+9FDC/5FGBpuHpgutiZxaqMgwDsOuEuZiOdJuHjYsl?=
 =?us-ascii?Q?eRYZTMM2JqEXb42vF2koCP636Lbu/X2LkhKCdOO404MrahXr9lVHONjnTokR?=
 =?us-ascii?Q?91aMrAUAIZLfK4+qccpKu8hIfLWDt+YDYBOKIxYRq4rjqgoCy1RYDgLpMnQo?=
 =?us-ascii?Q?5eLo9nDV2M5UHidv3qzObrUyMzUtCKeyDQ1x78yKsUZJNxJiydH/rm83FFWP?=
 =?us-ascii?Q?Ou0Cko7UmC81rgy0SFOWENn6o5o0iSc/eVH1XckD4tQxyxtKgy0Ox0jw79LR?=
 =?us-ascii?Q?hY7pEp1ec8vwjG7ebnVDCjl3WjYdGhsNh/dmUNiIWFASjDnofD9fTP8j7spV?=
 =?us-ascii?Q?35auzYglgfhKr2qRnU4BDynqzcE8eAhp2iDZ7hil0m4VF6m/zDS57Cfe3ByR?=
 =?us-ascii?Q?/Nf+qSL6WdBlZ673ZDF5EperIwi2wPBcXpFF2J0poc6sY1BZT86Cj+e54b2y?=
 =?us-ascii?Q?F05lQ9dJE3Pq3T5zI0Da0SKpPlfVhRHA8PCAjHYpJW0nLYwkGqcRGSeC1stj?=
 =?us-ascii?Q?e4E2xctG2gAdId6oXBs07eGB8L3fPr4+Z2JY7MYaixQFYQsKK9RSQO8TUmLl?=
 =?us-ascii?Q?diicMkxZ6phi7LgiVmBsjAZwN05FFQFqkEC/XEYkms+cZn9R5zlpCLxK+s94?=
 =?us-ascii?Q?D6/sdHc4oFM8q8dcNEL/CsoyYH2H1OQX/jF9SX3CEe1cdSX7P80kZS80Zxr4?=
 =?us-ascii?Q?fnS8SaXdvLm95ediNfz+pCW/twfpQRdc4oUCpBELqEhRxzJlvnW/YfQhSshS?=
 =?us-ascii?Q?nhqREoXvBXx59l6CDogRcltkggK3H+llQraNVypCvBaj9poftUlr2FgznAt/?=
 =?us-ascii?Q?mwRIliQiPtnX/W9XWuv4HHMxd7fJuT1SI4tgdMe8eiLKbE/ZkOaaGUsM5W4v?=
 =?us-ascii?Q?qKsPDnIKIs3E27DrmGdQ4HygcCYSB4OaldI19hn0eT7/RlTMxb7k3fWZKlRz?=
 =?us-ascii?Q?8l/pCMbd9dDs6fzxGqJQh8WoSXJPIx46Mt8LyXIF6HUH3PKyR9VJ8NSQxt4G?=
 =?us-ascii?Q?8k/K5FCb5lWCvRdvS1yCiuIMDGQamP+Rv13cqeZPXJnRla8YChP9ZL2DwOKQ?=
 =?us-ascii?Q?LVjZ3C39VB01SWRMoBGSYG22?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ded4835-e0fd-4dfa-245c-08d92d9d44c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 12:26:13.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mERWjNvVTL+pfWkOuuIklVqGEBSHFbI9DAgimHQaSasZJFWBz7GeM61cwrOO/VGmqZ8DcbqlBjqPjDx4fpZ/13Iz2Y9alcFkFi1VgB5Ogh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5686
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
>=20
> On Fri, Jun 11, 2021 at 12:36:38PM +0100, Biju Das wrote:
> > Document RZ/G2L DMAC bindings.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../bindings/dma/renesas,rz-dmac.yaml         | 132 ++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > new file mode 100644
> > index 000000000000..df54bd6ddfd4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;data=3D04%7=
C
> > +01%7Cbiju.das.jz%40bp.renesas.com%7Ce46660b298b942937fe408d92d109c19%
> > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637590371623792000%7CUnk
> > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DkirztzPuCmsjeKEivOgQZqP5obsByrSaTn=
Q
> > +bzQbU%2BRM%3D&amp;reserved=3D0
> > +$schema:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das=
.
> > +jz%40bp.renesas.com%7Ce46660b298b942937fe408d92d109c19%7C53d82571da19
> > +47e49cb4625a166a4a2a%7C0%7C0%7C637590371623792000%7CUnknown%7CTWFpbGZ
> > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > +3D%7C1000&amp;sdata=3DU2lrBvVVhySXVYHK6Qk41VTGijep8yPaTCMJpSjRsXs%3D&a=
m
> > +p;reserved=3D0
> > +
> > +title: Renesas RZ/G2L DMA Controller
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
> > +      - const: renesas,rz-dmac
> > +
> > +  reg:
> > +    items:
> > +      - description: Control and channel register block
> > +      - description: DMA extension resource selector block
> > +
> > +  interrupts:
> > +    maxItems: 17
> > +
> > +  interrupt-names:
> > +    maxItems: 17
> > +    items:
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
> > +      - pattern: "^ch([0-9]|1[0-5])$"
>=20
> Is there some reason these need be in undefined order?
No. I will make it as defined order in next version.

>=20
> > +      - const: error
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#dma-cells':
> > +    const: 1
> > +    description:
> > +      The cell specifies the MID/RID of the DMAC port connected to
> > +      the DMA client.
> > +
> > +  dma-channels:
> > +    const: 16
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  renesas,rz-dmac-slavecfg:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      DMA configuration for a slave channel. Each channel must have an
> array of
> > +      3 items as below.
> > +      first item in the array is MID+RID
> > +      second item in the array is slave src or dst address
> > +      third item in the array is channel configuration value.
>=20
> Why not put all these in the dma-cells? You already have 1 of them.

Thanks for the suggestion. I will make use of dma-cells and will remove the=
 above property
in next revision. Basically It simplifies the implementation as well.

> Though doesn't the client device know what address to use?
Indeed. it knows.

Cheers,
Biju
>=20
> > +    items:
> > +      minItems: 3
> > +      maxItems: 48
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - '#dma-cells'
> > +  - dma-channels
> > +  - power-domains
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +
> > +    dmac: dma-controller@11820000 {
> > +        compatible =3D "renesas,dmac-r9a07g044",
> > +                     "renesas,rz-dmac";
> > +        reg =3D <0x11820000 0x10000>,
> > +              <0x11830000 0x10000>;
> > +        interrupts =3D <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> > +        interrupt-names =3D "ch0", "ch1", "ch2", "ch3",
> > +                          "ch4", "ch5", "ch6", "ch7",
> > +                          "ch8", "ch9", "ch10", "ch11",
> > +                          "ch12", "ch13", "ch14", "ch15",
> > +                          "error";
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_CLK_DMAC>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg R9A07G044_CLK_DMAC>;
> > +        #dma-cells =3D <1>;
> > +        dma-channels =3D <16>;
> > +        renesas,rz-dmac-slavecfg =3D <0x255 0x10049C18 0x0011228>;
> > +    };
> > --
> > 2.17.1
