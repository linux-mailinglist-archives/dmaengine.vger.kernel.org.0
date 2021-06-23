Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665263B1C6E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jun 2021 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFWO3s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Jun 2021 10:29:48 -0400
Received: from mail-eopbgr1410102.outbound.protection.outlook.com ([40.107.141.102]:40117
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230334AbhFWO3s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Jun 2021 10:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO7qAwUUW3ukpHCcWE4SdE4apQIrf3dPpXvdAC6ZYHm7WMqXjhSb6Tpm+gzeh6HrkkmQg43doAR5qPFCdftJ3yn4voC+8CKUGzn4/FcGZ4hgrDLbiCHskDRyYzskXrFe+L6evZXd/EoE8H+vyeMwTpSreMT3VCFxSHrE3TPs2WAT/4Chh37L34fr671e/bB/pHIZ4uF+zq1qtqxb4vXe0+lklO8Cia9QVT4joGiR/PolMtWCLWg9bglmmFdIfVngVK7I7hWXwkmOxbERhuWxbr6kvpgNtj0cxIR3hzCbQpO6+1vM6liBtBaI3o26twWNYrSGPWabu8GxNpNFImGjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLN9TN8satqIt3SpJVcyW6kS71x3oaNrHe1zV02Rc2M=;
 b=k5rHaYFwEewGK0ik8DzaRBkhlXGP0WKLRu+aL5UFcOvN/Utsey9anrJK102o7tUnuHTMkDtzJihvOSRPpRvtmJLihpiRW32hMbmdzXCtqWf7rr4sN3XH7pWBJHltyf2g55fF6udFjt0hqu5El6ImOlbtipvEVFeCJvnqCxhW2yj6CNT6xpKMrWPV8hWz7zslwUdxgBmOvL+vWMbl/uRcCwNLCVdTd9R41B8ZR5LbBLbuXA0ILKqn3GAmHUOnjddCSTRwRJJvLTlnXzW1Raotc2Wtl7pZhnJcE909EgdcMK6aF9Xo0UEEJsdPYzzmHK5aO3Fc8IAk3aKHdnPV01Qj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLN9TN8satqIt3SpJVcyW6kS71x3oaNrHe1zV02Rc2M=;
 b=Ehf/fIo/6OK4quQTI2PUIeFeF64jOjoexJTZt7zburEf7BiY5AUQ7J/7KOf8AVmGz3fJ3jdDDfIKtP19vRp5EJIiR5hWKXJt0YDis2ZT5SAJC3Rx97qrjqNk87fOcrfq3O8BmPlPZo7V1OjCWo5K04Kmhtxcb+jy/ho4RDp25yg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4980.jpnprd01.prod.outlook.com (2603:1096:604:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 23 Jun
 2021 14:27:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b834:5e50:2ce8:9ae0%3]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 14:27:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] dt-bindings: dma: Document RZ/G2L bindings
Thread-Topic: [PATCH v2 1/4] dt-bindings: dma: Document RZ/G2L bindings
Thread-Index: AQHXZqpyYoCEnEXFLkKbcK30nQnRJasgcNaAgAE5J9A=
Date:   Wed, 23 Jun 2021 14:27:22 +0000
Message-ID: <OS0PR01MB59225A4CA77059294F05216B86089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210621143339.16754-1-biju.das.jz@bp.renesas.com>
 <20210621143339.16754-2-biju.das.jz@bp.renesas.com>
 <20210622194459.GA3755@robh.at.kernel.org>
In-Reply-To: <20210622194459.GA3755@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [86.139.26.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ad3f56-2f89-4839-da2d-08d9365303cc
x-ms-traffictypediagnostic: OSAPR01MB4980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB49802A6DC6F17CC462643A8E86089@OSAPR01MB4980.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ss8hzqn2n/+lVWOVT6HVM3J8m+m73V0JNALc/TBpjk9FTVd3+pv7kL+HoMZ95a8/WZw+Ncsa605GIa+fAOPyRWwXgHpFh1Km/J+7P/yWS06BupBeduSspDiguKX47mWoeoq/KggJlpJyTm+i6zJ1sow1M8m+QdelaoRIpauTHafiNebC/+XTTdMzdgXzQ5iTXqcfFIzpDLwWOFGsiGqiqiahK3j5iZsyDs9HagV+P5e79IAZ8ecdCxt5MzPBQg1NY71qCx9RFVBcCSTg6mXjCmAg67Ueya8Kda7w1Bzy1v4DoBJU0lqOJp+Je1z/VrqLhxPe0LEw30NDBlu3M040jOdE9FkjyMVSf1Yzyta18cqt0nwf31HiMGljbgzehhsbVftVIHcM5CmCNF3/cjPVgqvqGE9KuWUoQixF9Es4tGytRAl+arytvFJScxnGt9KbDsrzpREZ0yXyLVIPQ4YcG9xoqQLHOntTBnal/ASzeNZqky5YExnkdkDMN86esCMXLpworFQ+CIWjUpVi7u2wF8qh6K3gun0u2GoOrwSavA74ud80Qdvd6gnjnegjCrU496YJv4jK3adq3r1dUSUewsZAXIr3qshPphnoPPpFq0HrGwwE0e/XGjS4kEZPqp1iOQM/LXCS395TKppg/w9/aMq6TUdhEjav9ouL7cwcbipCv/96N8j/qR3rPne4XBgE7bUKViVUPFgrqNi/Zj0MaA0vboRN7wmK9hAqAgZS/JlMFRv0V0gNF/vRsX0zPPU/eoIWG38PK/PEI05qBzsHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39850400004)(136003)(376002)(7696005)(2906002)(122000001)(6916009)(38100700002)(26005)(186003)(478600001)(6506007)(9686003)(4326008)(86362001)(55016002)(316002)(966005)(54906003)(33656002)(45080400002)(8936002)(71200400001)(8676002)(66556008)(83380400001)(64756008)(66446008)(66476007)(66946007)(76116006)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5LwFjIN++7bLdArdzq2VDD6BQnrQYJWMTSl618DYbzpPyS12n6L9AMn6Y2bp?=
 =?us-ascii?Q?MMHD4wgU1OmbQneTE0lWefG74z1hZZZ4uTdc3bcQ1+DCSpnX1lnkefu1BIUA?=
 =?us-ascii?Q?o0l/+j0n+Em0TFYx4rSaX0O6wge7Jk0X4Bxi/vk2hq0u1pegF/0vdZkiKynQ?=
 =?us-ascii?Q?C4Vl9qus2B0I5FDlpsmWzG6R3veYVcqKAVvjRW2hPFN1Gg0lqerSVuL4u0V7?=
 =?us-ascii?Q?YljXeCpS4IwD/i3ly6Z6ogGQur63gL+sU6BZzm1ojlwtQNWRcLDqpt/O+tMQ?=
 =?us-ascii?Q?ZpdHs9waSWeFJ6clnUYYj6uIc5iN1IxNdvzUvDyhKnVr/rmzOd7E+wT+6pWA?=
 =?us-ascii?Q?CIfmtDw5ZHhilK2+iYzRWUgclObq3V73iRz0yUZ4PKAfIgitntlR3lUw4FFf?=
 =?us-ascii?Q?FPgqlsaLRaXEO4NYUeOdUO+7HccUGhNAD4CQXXBk9YQB7RsTZKs24skAjTC0?=
 =?us-ascii?Q?VwUaEBoeGYTSyLvZcdLSBgYRdr6BWHP6U2189mFgqnlaNPuBb2ANNFtEEQ2E?=
 =?us-ascii?Q?wc7Z1sdOHPUXjKovzu87sAvrG3mWJjAaI4s/NK3ZqI13lGVjNWJiIsO8H/YP?=
 =?us-ascii?Q?XnT587lcPEOWi4T8a8qOE6dokmxMlLRH9aW+zqLsDfckTkrgRXFSJ9RgDUa8?=
 =?us-ascii?Q?M4IANyPVGHTVFHDLmdEG/FKPHG/YqeMqfbo3P6yO1AVX28GXQ6HYZMpUpoLW?=
 =?us-ascii?Q?hRqmr5xF6kT3yvPybjPMVgbC4BlACe3JMk6YuK+PiE0C0R0sREUFMGzs59qn?=
 =?us-ascii?Q?WwhONgaFHuUb+SVbL/jVtedverQGkFzJgEmyhvXHR6JJvbJY6dTtmHJV4EDY?=
 =?us-ascii?Q?j8YHOLHOqrLzEBP3QKhNokK0iKLnLMggabwklMpxsTr6oPN846LZwcWQYQSb?=
 =?us-ascii?Q?NmtFaBNFHvOrJj5eymjo7csOppdJOGa70L/Qe3U076a6XnsZtuIwEe0ccfKu?=
 =?us-ascii?Q?r6nZX3sxYYK/dZaN8bk6lZRbeMfBC+0EX9r/tyKrsgOVTGPkFWL/NaW/cGzX?=
 =?us-ascii?Q?lpQparDldyP0ARwXk1fKq8drgvbby4kqo0zea3nPcQXLqURexNc5D4y4EW3I?=
 =?us-ascii?Q?as+Jk/wI5Qx0JQPE1Tp9/627bHPmrkGWb+7m9mEDwbIDqBqyWI+z00qFLC1C?=
 =?us-ascii?Q?yYdS2y0fPI7N/g/+NdbJHPvKH5WyaJSRYR2Z6R7dAr+okWRLPgOp46ABfq4S?=
 =?us-ascii?Q?fMAKGk48EgamjBzLkasfy7HeTT7VBt8vzCuPkz8Al/mp537cn5NU41DEhtTI?=
 =?us-ascii?Q?f8HtYoJ3gUKDmCEi4YTA6G7c6vsk103hs31HZ8dZ7gHtBe/lPO7Xvbrs4Gpj?=
 =?us-ascii?Q?SuUEEKS+B/32Z1ESpnmVGtBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ad3f56-2f89-4839-da2d-08d9365303cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:27:22.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR1XuDqHdcbaw6OxDDXgazr5fboZvkHLCAFaInWRJNw+RljNbGFzP63prcQ7tFS3U7NJkCgYGByBQ0nURNNT5MYI5ErTNwYmMQ0w02MwXSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4980
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/4] dt-bindings: dma: Document RZ/G2L bindings
>=20
> On Mon, Jun 21, 2021 at 03:33:36PM +0100, Biju Das wrote:
> > Document RZ/G2L DMAC bindings.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Note:-  This patch has dependency on #include
> > <dt-bindings/clock/r9a07g044-cpg.h> file which will be in next 5.14-rc1
> release.
> >
> > v2->v3:
> >   * Added error interrupt first.
> >   * Updated clock and reset maxitems.
> >   * Added Geert's Rb tag.
> > v1->v2:
> >   * Made interrupt names in defined order
> >   * Removed src address and channel configuration from dma-cells.
> >   * Changed the compatibele string to "renesas,r9a07g044-dmac".
> > v1:-
> >   *
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-renesas-soc%2Fpatch%2F2021061111364
> > 2.18457-2-biju.das.jz%40bp.renesas.com%2F&amp;data=3D04%7C01%7Cbiju.das=
.
> > jz%40bp.renesas.com%7C148e8caa6dad418a945f08d935b63b07%7C53d82571da194
> > 7e49cb4625a166a4a2a%7C0%7C0%7C637599879065585493%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C1000&amp;sdata=3DoMUg74TGAm%2BNelP1na314IdJojqHY0TGvr01y7i0HlA%3D&amp=
;
> > reserved=3D0
> > ---
> >  .../bindings/dma/renesas,rz-dmac.yaml         | 120 ++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > new file mode 100644
> > index 000000000000..0a59907ed041
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > @@ -0,0 +1,120 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fdma%2Frenesas%2Crz-dmac.yaml%23&amp;data=3D04%7=
C
> > +01%7Cbiju.das.jz%40bp.renesas.com%7C148e8caa6dad418a945f08d935b63b07%
> > +7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637599879065585493%7CUnk
> > +nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > +wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DV3tJCTBjLjFfR1Hm%2F3hU64jrgSL1qvXo=
j
> > +e%2FeBPBCjy4%3D&amp;reserved=3D0
> > +$schema:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cbiju.das=
.
> > +jz%40bp.renesas.com%7C148e8caa6dad418a945f08d935b63b07%7C53d82571da19
> > +47e49cb4625a166a4a2a%7C0%7C0%7C637599879065585493%7CUnknown%7CTWFpbGZ
> > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > +3D%7C1000&amp;sdata=3DFPhQ7PGQlnhj%2B%2BNJ%2BSCJvbOMXlYXUbaacEfBKib80K=
U
> > +%3D&amp;reserved=3D0
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
> > +          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> > +      - const: renesas,rz-dmac
> > +
> > +  reg:
> > +    items:
> > +      - description: Control and channel register block
> > +      - description: DMA extended resource selector block
> > +
> > +  interrupts:
> > +    maxItems: 17
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: error
> > +      - const: ch0
> > +      - const: ch1
> > +      - const: ch2
> > +      - const: ch3
> > +      - const: ch4
> > +      - const: ch5
> > +      - const: ch6
> > +      - const: ch7
> > +      - const: ch8
> > +      - const: ch9
> > +      - const: ch10
> > +      - const: ch11
> > +      - const: ch12
> > +      - const: ch13
> > +      - const: ch14
> > +      - const: ch15
> > +
> > +  clocks:
> > +    maxItems: 2
>=20
> Need to define what each one is.

OK, will describe the clock items.

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
> > +    maxItems: 2

OK, will describe the reset items.

Regards,
Biju

>=20
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
> > +        compatible =3D "renesas,r9a07g044-dmac",
> > +                     "renesas,rz-dmac";
> > +        reg =3D <0x11820000 0x10000>,
> > +              <0x11830000 0x10000>;
> > +        interrupts =3D <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
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
> > +                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
> > +        interrupt-names =3D "error",
> > +                          "ch0", "ch1", "ch2", "ch3",
> > +                          "ch4", "ch5", "ch6", "ch7",
> > +                          "ch8", "ch9", "ch10", "ch11",
> > +                          "ch12", "ch13", "ch14", "ch15";
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
> > +                 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg R9A07G044_DMAC_ACLK>,
> > +                 <&cpg R9A07G044_DMAC_PCLK>;
> > +        #dma-cells =3D <1>;
> > +        dma-channels =3D <16>;
> > +    };
> > --
> > 2.17.1
> >
> >
