Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9722C2DD
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGXKNr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:13:47 -0400
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:27840
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXKNq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMyDZb3dTjfd+Q0LR2aVj0Pxk7h7ICRvXoBvgy0GNbLEhkJvTUx7vYtF/pPepMmFWo2cMmZWZUBGMI05Xi1lJXr8M2sjjlrNvn/tJnmh4+9cdMtXd3WkpJBEM+CHVO2WYLujBgKQ5+yDdzal2wg/ywuQ/ZQR+pySpDu14G5wIA7JLXu6Eyd3cR5tySURK7cNC3mhlpZdfPgEG+aREk4WUwQvhpL8jM7d7AD0VB9UlT+86RYoasSURmzb+m3l8mJDV9cDPZNzna5bnrkwY7OWb7qXtzMCRc2+VFC08hYSsbET1X4sY41Z9zbNQ76NjKjt/3p6jDYqG4Xu+tGFF3p6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUCHpDaS9jcMIUeqt9A7i1pFlnLXuWw4VtilU4Q51fY=;
 b=KHID1gc8od3oWr0UcojRjRRYXHNouQXopghGNF1g7c84bLoKy4hPhQnHTg5kILZZcnV/gTHavoUb+hwgt8gZ1lur9ZBUu+WzA+PoPogahcoee+qfLOHwacc4eMmmlmdeWbNOU8OJ8vqm4zh3oFS5jYeMjAufjQB3rS8TphZ532EdTBNj6RBUPHHcgnvWldlXy8MpyePAFAqYrWE14b4hDnZvuvixMMhlfaRnJEDIx8N+/8ev+bSdAWhmSgdI+nvP41xI0lD73fIxsBvIX+oT/nn03Acm3jUtxC4d9KF5HlKAwFF7LArF0Ae05g53owFhZYtpbaAUK2V/AH2DC6tr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUCHpDaS9jcMIUeqt9A7i1pFlnLXuWw4VtilU4Q51fY=;
 b=SvxLsNm9I/9m5ObDHdUC1i89XF2uARkF7He6yX21WYNld3XAdjyCnctZIyjh6dUmClUR4IWcwkN8l99/YNLa75xfvIsGZpW7+v35g164AhUlPY562Hc3djM+bX3mSMaTgiN+rMtZjohj7o7uno6Vx1a/XJIq18oPf1/wSYw36Y8=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 10:13:41 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:13:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "angelo@sysam.it" <angelo@sysam.it>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 6/9] dt-bindings: dma: add fsl-edma3 yaml
Thread-Topic: [PATCH v2 6/9] dt-bindings: dma: add fsl-edma3 yaml
Thread-Index: AQHWWcEHFW49eRTRd0i86/lmLEZUy6kKoHIAgApw4+A=
Date:   Fri, 24 Jul 2020 10:13:41 +0000
Message-ID: <VE1PR04MB6638C3006D405D9C8E13547C89770@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
 <1594748508-22179-7-git-send-email-yibin.gong@nxp.com>
 <20200716194746.GA2716872@bogus>
In-Reply-To: <20200716194746.GA2716872@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43b7d7da-1d0c-4d6c-4e9a-08d82fba3d5e
x-ms-traffictypediagnostic: VE1PR04MB6640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB66408BC810B33E386472262E89770@VE1PR04MB6640.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +voL5hZHm3Zi8oFZWlzrLikgvEia9C84SztbCvIZnvH/6wN6kaS+1vYKEnYqwwozsjb8DdY5VTYAmoyzYwUm4Dq+wFoD6/oQGDxVTr7PIbvWMMd1VvV2WvC9AUl7aaJZbLboX69b+KJdwUVZMZTTs0bT63kb/EBaNGpV3NCSPZLG+R5ps1Z5Fl3tDvNjARqk+nyiu+sZMZJ9LBoKeXvTMW/+tI9gyQnVgaRG+v03PCKmSe03wOeKVxSM1mjJDrCf7cwwPeWecyNZHF98QUh3gNw6KyssgY5DhlOS13hH5NGFLHziiYWcWKxcrZkE/VFg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(186003)(86362001)(55016002)(4326008)(9686003)(52536014)(33656002)(7416002)(2906002)(66556008)(7696005)(76116006)(66946007)(66446008)(64756008)(66476007)(71200400001)(5660300002)(54906003)(8676002)(6506007)(316002)(26005)(478600001)(8936002)(53546011)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DTWZGAtScX5rUh0mBIsbm9C7HUbqhs4RaoCxLNPOElDZdH6sz7slct+VVTNAMirBDaZPJZzmqS/2mbYfuBUPe3lCEA4jB0XGczw+eilFCOA2RB+bjWWh44gq7HyRXuIXRDw/Uu6yqkIlpxPtnkACtY7Xs48VFK/rHQU30eNzFdSbULIK7qA+pXLOKcUDNjzkch8O5yEnaQ+yiAYjAUlYCmf15HgKQ8UUQgCb1CDrLDJzaBBLz7URDyKP0Q0G6YkYWBM9HEWuZBxB9XVbAXfqX2kvL1wcp8u45h/qOcCuFqrLfb5kJCSH0uFzX7S/48EzXMP2vMK4tIO04DLKVuzQtFuWWE/BVxKwP8zpP0lM6LqJ83YYwACfSQcOx+zheh8tjPkT1OCw7B/0TZvx4snISG27mj45covTeD/mEDeWJB90eZk9OEsoNKD9Vv2rqbWq2lEEYAgF2p8EPcBW007qqP5pgdIXzR0eWchZsP0zHd0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b7d7da-1d0c-4d6c-4e9a-08d82fba3d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 10:13:41.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ923lzmJLn9ZofjqoU6ncIIJvnvx6mG22/VGn1MUIVWhN8JEzppQnNovLydmIWv5e4Wu5SqTcBlkOGJLXCGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/07/17 3:48 Rob Herring <robh@kernel.org> wrote:
> > +
> > +  reg:
> > +    minItems: 2
> > +    maxItems: 32
>=20
> Needs some sort of description as to what each region is.
Okay, will add it in v3.
>=20
> > +
> > +  interrupts:
> > +    minItems: 2
> > +    maxItems: 32
>=20
> ditto
Will add it in v3.
>=20
> > +
> > +  interrupt-names:
> > +    minItems: 2
> > +    maxItems: 32
> > +    items:
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
>=20
> What about interrupts 8-31? If you want a pattern for all entries, you
Here 8 lines matches with the 8 channel used in dts (same example as the
bottom of this yaml file below), otherwise, below warning comes out with
'make dt_binding_check' if I remove the above last line:
dma-controller@5a1f0000: interrupt-names: Additional items are not allowed =
('edma2-chan15-tx' was unexpected)

Maybe there something I miss, please correct me if I'm wrong, thanks.

> do:
>=20
> items:
>   pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])-tx|rx+$"
>=20
> (If 'items' is a schema instead of a list, then it applies to all
> entries.)
>=20
> What does edma[0-2] correspond to? The names should be local to the
> instance.
There are 3 edma controllers on i.mx8QXP/QM, [0-2] is controller index.
Clear controller index here may make dts readable since every edma channel
has unique register map, interrupt number, power domain.

>=20
> Really, what's the point of names that just have the channel number in th=
em?
> The driver can create names dynamically if needed. We already have
> properties to define how many channels and a mask of present channels.
interrupt-names/power-domain-names here just for better readable in dts, be=
sides, the clear interrupt name for every channel including edma controller
id which passed by dts could be used to register irq.

>=20
> > +
> > +  '#dma-cells':
> > +    const: 3
> > +    description: |
> > +      The 1st cell specifies the channel ID.
> > +
> > +      The 2nd cell specifies the channel priority.
> > +
> > +      The 3rd cell specifies the channel attributes:
> > +        bit0 transmit or receive.
> > +          0 =3D transmit
> > +          1 =3D receive
> > +        bit1 local or remote access.
> > +          0 =3D local
> > +          1 =3D remote
> > +        bit2 dualfifo case or not(only in Audio cyclic now).
> > +          0 =3D not dual fifo case
> > +          1 =3D  dualfifo case.
> > +
> > +  dma-channels:
> > +    minimum: 2
> > +    maximum: 32
> > +
> > +  power-domains:
> > +    minItems: 2
> > +    maxItems: 32
> > +
> > +  power-domain-names:
> > +    minItems: 2
> > +    maxItems: 32
> > +    items:
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
> > +      - pattern: "^edma[0-2]-chan([0-9]|[1-2][0-9]|3[0-1])+$"
>=20
> Again, why do you need names here?
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - '#dma-cells'
> > +  - dma-channels
> > +  - power-domains
> > +  - power-domain-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    edma2: dma-controller@5a1f0000 {
> > +        compatible =3D "fsl,imx8qm-edma";
> > +        reg =3D <0x5a280000 0x10000>, /* channel8 UART0 rx */
> > +              <0x5a290000 0x10000>, /* channel9 UART0 tx */
> > +              <0x5a2a0000 0x10000>, /* channel10 UART1 rx */
> > +              <0x5a2b0000 0x10000>, /* channel11 UART1 tx */
> > +              <0x5a2c0000 0x10000>, /* channel12 UART2 rx */
> > +              <0x5a2d0000 0x10000>, /* channel13 UART2 tx */
> > +              <0x5a2e0000 0x10000>, /* channel14 UART3 rx */
> > +              <0x5a2f0000 0x10000>; /* channel15 UART3 tx */
> > +        #dma-cells =3D <3>;
> > +        dma-channels =3D <8>;
> > +        interrupts =3D <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
> > +       interrupt-names =3D "edma2-chan8-rx", "edma2-chan9-tx",
> > +                         "edma2-chan10-rx", "edma2-chan11-tx",
> > +                         "edma2-chan12-rx", "edma2-chan13-tx",
> > +                         "edma2-chan14-rx", "edma2-chan15-tx";
> > +       power-domains =3D <&pd IMX_SC_R_DMA_2_CH8>,
> > +                       <&pd IMX_SC_R_DMA_2_CH9>,
> > +                       <&pd IMX_SC_R_DMA_2_CH10>,
> > +                       <&pd IMX_SC_R_DMA_2_CH11>,
> > +                       <&pd IMX_SC_R_DMA_2_CH12>,
> > +                       <&pd IMX_SC_R_DMA_2_CH13>,
> > +                       <&pd IMX_SC_R_DMA_2_CH14>,
> > +                       <&pd IMX_SC_R_DMA_2_CH15>;
> > +       power-domain-names =3D "edma2-chan8", "edma2-chan9",
> > +                            "edma2-chan10", "edma2-chan11",
> > +                            "edma2-chan12", "edma2-chan13",
> > +                            "edma2-chan14", "edma2-chan15";
> > +    };
> > --
> > 2.7.4
> >
