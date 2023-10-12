Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A37C695C
	for <lists+dmaengine@lfdr.de>; Thu, 12 Oct 2023 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjJLJWa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Oct 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJLJW3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Oct 2023 05:22:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1FB7;
        Thu, 12 Oct 2023 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697102547; x=1728638547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BHQ2ydJCtKeupid8v1XaqUARqjaKYJnc4oucG0gtUkY=;
  b=JvuPUpYwyBhj+ycxh0VOPRtEHukqqAa9taI5UTv21Tg0YKRaL/gy3yCn
   0qBA9BkatdzxkKVYa5PlISf8PTq5jYeoUB5VZRdpnqlGtJHSBGkV/8aaS
   vHV8xvN1iWMzjsqvOco154PV0JFD+RYKuxJsehI2peBMdIn06ZvSDJ6QB
   YiFX1GBbB4IgnskSJSUIU2O7DleAEB6jbz3yk2lpDMddSB7pZoP7lLoqx
   +fAbL51/fcbXzfpk9pQyVLRAXc6myT0P7st2JnzVxuth/0EwDnbeHHsIs
   ZwPTzn6OrlRmmJJbO/zr3L9HDJbd6JqBJ2cOBcr2pzJfAIBayFlt9B9AT
   w==;
X-CSE-ConnectionGUID: VPTxc9TuS1aNSHQz3ISOnQ==
X-CSE-MsgGUID: Us47qmmkTOiRFW67U7Yy9g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="10080421"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 02:22:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 12 Oct 2023 02:22:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 12 Oct 2023 02:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdlHu1zQmBApxPLlP2+ZtYp1uiTKBA1mv5+9RUSyzve08QKFDivLZQuqbccKVgH4s01vgrI03ov6U9BSonlUAJ/qb51lmjRik+20VjxIzI63AtiqWrSU0TiWp465HdnhZtORlGWd43z/a+4EaWiYOvnkvBrIG+JJQ1pvo+/Z3gNZIkpVfU5O2TuBGKjdtyl8ySEBeEfJVlM48Lr8NFxD5EcccVKJZTB39yaZEaatnXfvAazRhyFNPHQ8XzOyAaTx4qlklNW5q73NhPA4csLwNnmQfxuDm3cYesEYvsD1M4Y0A265EgxK4qhabWTroHxrJVipHh/CTD4Y/x+4qEy+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbdW8G/XwVOXff+s1oYCrywlrZ69hKMpq6M9Qv2VCLM=;
 b=WJt3gQB8Aj1j7zMzdt9eVpcth5mfcT0rEHOo8shra3RtVI9Iba0ws/XyGwZUyUthQIDxsSFIallVuNY8/ph/to43TBHiXRA5svrw0jyKYMykKEbiEa97WNN6Qi4GpOm8rqB5wZKyAmUyf1RqBO5sdY62YlTpl8QrpRZpkQZHKgsSxl5fj+xENo2/T1BZvKCF54Jkqisb4tKfc8u4k/cYiVlb3t25JlBIwYI7Al6W0ji5/ELCEJei4hI0YEUgj0VO5eqc/InP1a7l5H76sj1R3WERWwWeUTsPZ0Oh81Qd1OnG2RSzvFvewK1QfGAnbhYFMXR/3Lx8aSfA7/b4qdbXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbdW8G/XwVOXff+s1oYCrywlrZ69hKMpq6M9Qv2VCLM=;
 b=AL0ysre5CTE8dQrOhk6CN/sjT6l4ig8a9KWtTsA+Kn23kVvfsxVpMIvieDLb/1q0MBY3iC7ox2suNec0IfY+HZvQh35yMrfLdF4j4hWaWmThRQracYSk+YyF1Eboxn944FUrp6AExmvtyi361yfQvjXQ9tJMaLHsyoUyaptvYhk=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:22:18 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 09:22:17 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <conor@kernel.org>, <robh@kernel.org>
CC:     <green.wan@sifive.com>, <vkoul@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>,
        <Conor.Dooley@microchip.com>
Subject: RE: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Thread-Topic: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible
 name
Thread-Index: AQHZ9bEPzvlreOUVh0GGXZcZopv3N7A5onaAgAFmyICACuaOsA==
Date:   Thu, 12 Oct 2023 09:22:17 +0000
Message-ID: <PH0PR11MB5611CDD7C66363B9F2367C2881D3A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-3-shravan.chippa@microchip.com>
 <20231004133021.GB2743005-robh@kernel.org>
 <20231005-wanted-plausible-71dae05ccc7b@spud>
In-Reply-To: <20231005-wanted-plausible-71dae05ccc7b@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|CY8PR11MB7195:EE_
x-ms-office365-filtering-correlation-id: ce61431f-4d68-493b-9454-08dbcb04badb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n0kh9fcIHLD1A7rZ7Y7JkfebZW1+4nqDnvGo8ic/A9v1AKg6+KJWlI3kpXLknXpmheXIpwJcUG4M2o9v6NuJP2/rD1A4dQqyPqRV9L5a23Bo1jwP3VPgl9hGBEgd9NnJGcT0q14s9ocpbMvaSmycrDqmgMY53Fi7P6QUwaz3iIlXbWSw6/B2k8j5GoroJHzSDGI6nD8davmLdZwYngDIk9ZaqP1N9XI4fsF3+SHbuXzeHTiu6Ze8t05xgizm7SwuYN4d1Z5PwV9NCIxRLaVyZQ6sLjxicQ2T4OEk2jpb9aGO2SKdXWZFR6gYKMacYuXzc3WtTSb2kV/iGnxujeljqLKw8RIdvRTNWuZYShmgGiB1cTD+eXHniCPMgKp4pUxQbvF7p3ZwXAvV2UpQCkPY58+YLNfCEchmQZ6QnPxUTVJSeaw+ErcrAV88IV1mv7wmWpIt7ChQiNmB3r0tlo++iyHh3/AXn1SPI3PqkrfGUzKy0PyOI/QfaiVgsEpv4UiVeUuugSBQ9EbZNT180oX8sNYqPgIzjymGAizErFOqtlQdN/dw/y0h9Gk5UhUDF0Ib7QMqO59/rIjoK5SS2+kAOhhOBZq+RX7y6l87FJrvlhuFwSYX2JaZI4/SxR/QDBcJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(33656002)(6506007)(55016003)(7696005)(316002)(83380400001)(66476007)(66446008)(64756008)(54906003)(66556008)(66946007)(76116006)(110136005)(53546011)(122000001)(107886003)(86362001)(38100700002)(38070700005)(9686003)(71200400001)(478600001)(2906002)(7416002)(5660300002)(8676002)(4326008)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v8ZsD5SDRW5JPpaVAR/j8aVviwxsHdxzfJ6KRPhM50U7c3g1utmO00wzixt4?=
 =?us-ascii?Q?OJ1pGdxb9Ekwt/uSYcHm3nvycZN95B92SHheTaE9weEo6Diw/ZIlI1peT/Np?=
 =?us-ascii?Q?Tl7Os81s9FfU8pxJ+AQAEZtufxBHytv9wjgsAwv1j56rcosCQ+n+LzWIuXpB?=
 =?us-ascii?Q?sDZhjvg6gD8gFG4n1zNtOaa6xPMky7CAtUp7vVLtgjU3jFfjEYByLDGiXP7b?=
 =?us-ascii?Q?vCbHUWDrSrIw2bFbIoe6PYd+Z+8q9xGesV42kJYzjXAGtm+QIp+qiRD/IpGL?=
 =?us-ascii?Q?+M+5nW8PWXQD2yGFVBJxWHzMrrYtSqQOlqN+9k4pl6GJVgxPXXOBfGacvTDP?=
 =?us-ascii?Q?30oqjnB7cKdOq4rOL2gtMNi5YmUOk7V7Z/+fSd/nf0UEJQcUw0lSQqFQBHEw?=
 =?us-ascii?Q?wS8TdM/c5fVUyFu7GIpaeiiveutVXV+V4HA81xsUDPUaSGafI35lifu8ovks?=
 =?us-ascii?Q?sba8lYB6o3fVS0giAMFaE1B6qqCOTV7j/+YB1h+KfVI9T8vx77khLJO7DdcM?=
 =?us-ascii?Q?tBmcZXx33+aF9xVPFnw/yo7hcxBxZFq5vASB5t7TPvUJhtv5aXZFKy6ArR2u?=
 =?us-ascii?Q?VWmf/19np+kzwSqwePJmnhaMvd0obIBBZZGs5FwNeVNQrO2w2jtAzTT4bkHB?=
 =?us-ascii?Q?qWWNiGMX4P/KWRKy1liUcuzkRQ3Wh4gNzOrxdCdLlbk7QWTBgCndyOuj8EJ/?=
 =?us-ascii?Q?IXpVP3nLZiPASIlG+a4pvvF/AAyq5bHgUTOTdkgHUZpCE6105+1ubAeGj/LL?=
 =?us-ascii?Q?pfd/1ULggI61ALGsRjByrl19XBGrS4nkJERm3Wnad5tCRdyP66yzd4aLFNl5?=
 =?us-ascii?Q?mcub8Qqtp+H66xRwXX2cIC7OdkI0DamR+xsZ39fmR1KLd62ll62iy92IOlTx?=
 =?us-ascii?Q?Zw4i1n/EZfiH9VxISHyoOl0vtVynkikx2cK1wn2Iqa4raWQJdA8RtW9AwXAZ?=
 =?us-ascii?Q?l0P2LnsnCkbu6aDVKsJmydH4YpekxThun7pA/Gix/BESXocbL/ZtlCrnwWq1?=
 =?us-ascii?Q?W8Mg323ftXCDIXGYtSFxdl/7zG6FQJ3212Zr9vFxq627taTynEK1cXxg5VUH?=
 =?us-ascii?Q?6AcjIQjsKiRr7hODcWgn7jrLWFKNZj7AbNU7Oc4t6mWPYna4yaCmEPZMUeGO?=
 =?us-ascii?Q?YTCU0GIu/TVo8wIdZaDRhf6MGPw4peocb8HAt9hvwHvgMRlPOcWmzQfvQka1?=
 =?us-ascii?Q?Em4585mHUNb38nskKGZ4he6kU4yP3Wdx5LTyc32gYSMbIVMKU01CRSzjcr3K?=
 =?us-ascii?Q?xLadZRScIT/dIsijIB3m21Cbhxaaa3/8JCvgrH1Q2W0zz+dCAAri6/0Yafru?=
 =?us-ascii?Q?UH91LMm5LN6ZhrLvKIk6hAaEUde2dOXS8Rt99RtujfHWnqOPuWVFUuPNsVS7?=
 =?us-ascii?Q?SgWDn7tugzBmre1V70u4e7dS6xvNQdlUiRgjxbE2xMztt8Pt1PCEMS/D8iwx?=
 =?us-ascii?Q?RLxgG1eKwUQzZyvzkFEnWbA843w62trCoixwl9zCjXVGA2OiTtXVyEaO11xs?=
 =?us-ascii?Q?P0cYCKPwhFOIkj3D3SuReXYW6/5IXhKSEw4GYSQoZj/odlvPRGCnqMOhOqrR?=
 =?us-ascii?Q?z7b55fMqwUV7XnYADHBk4k1FBGlf92lNA2h1IdmYM9tRCcjv8S3HPxunQzpr?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce61431f-4d68-493b-9454-08dbcb04badb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 09:22:17.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52EupeLkG54UMaQkvI5wMCvdnXplU2sGorML/BHed/oERhpcDyNv/3ljs0nck5WLg+r4tjG8MrCs8+gNIbHUI4OOFQ3x7cW3SoqxK0PnIWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, October 5, 2023 4:24 PM
> To: Rob Herring <robh@kernel.org>
> Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> green.wan@sifive.com; vkoul@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> palmer@dabbelt.com; paul.walmsley@sifive.com; conor+dt@kernel.org;
> dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Nagasuresh Relli=
 - I67208
> <Nagasuresh.Relli@microchip.com>; Praveen Kumar - I30718
> <Praveen.Kumar@microchip.com>; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>
> Subject: Re: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible
> name
>=20
> On Wed, Oct 04, 2023 at 08:30:21AM -0500, Rob Herring wrote:
> > On Tue, Oct 03, 2023 at 09:52:13AM +0530, shravan chippa wrote:
> > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > >
> > > Add new compatible name microchip,mpfs-pdma to support out of order
> > > dma transfers
> > >
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > ---
> > >  .../bindings/dma/sifive,fu540-c000-pdma.yaml         | 12 ++++++++--=
--
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > index a1af0b906365..974467c4bacb 100644
> > > ---
> > > a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.y
> > > +++ aml
> > > @@ -27,10 +27,14 @@ allOf:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - enum:
> > > -          - sifive,fu540-c000-pdma
> > > -      - const: sifive,pdma0
> > > +    oneOf:
> > > +      - items:
> > > +          - const: microchip,mpfs-pdma # Microchip out of order DMA =
transfer
> > > +          - const: sifive,fu540-c000-pdma # Sifive in-order DMA
> > > + transfer
>=20
> IIRC I asked for the comments here to be removed on the previous version,=
 and
> my r-b was conditional on that.
> The device specific compatible has merit outside of the ordering, which m=
ay just
> be a software policy decision.
>=20
> > This doesn't really make sense. microchip,mpfs-pdma is compatible with
> > sifive,fu540-c000-pdma and sifive,fu540-c000-pdma is compatible with
> > sifive,pdma0, but microchip,mpfs-pdma is not compatible with
> > sifive,pdma0? (Or replace "compatible with" with "a superset of")
>=20
> TBH, I am not sure why it was done this way. Probably because the driver
> contains both sifive,pdma0 and sifive,fu540-c000-pdma. Doing compatible =
=3D
> "microchip,mpfs-pdma", "sifive,fu540-c000-pdma", "sifive,pdma0"; thing wo=
uld
> be fine.
>=20
> > Any fallback is only useful if an OS only understanding the fallback
> > will work with the h/w. Does this h/w work without the driver changes?
>=20
> Yes.
> I've been hoping that someone from SiFive would come along, and in respon=
se to
> this patchset, tell us _why_ the driver does not make use of out-of-order=
 transfers
> to begin with.
>=20

I am also expecting a replay someone from SiFive
The out-of-order should work with other RISC-V platforms also.

I will try to send V3 with the below changes (just adding a new compatible =
name)

****************************
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -29,6 +29,7 @@ properties:
   compatible:
     items:
       - enum:
+          - microchip,mpfs-pdma
           - sifive,fu540-c000-pdma
       - const: sifive,pdma0
     description:
***************************

Device tree patch
*****************************
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -221,7 +221,7 @@ plic: interrupt-controller@c000000 {
                };
                pdma: dma-controller@3000000 {
-                       compatible =3D "sifive,fu540-c000-pdma", "sifive,pd=
ma0";
+                       compatible =3D "microchip,mpfs-pdma", "sifive,fu540=
-c000-pdma", "sifive,pdma0";
                        reg =3D <0x0 0x3000000 0x0 0x8000>;
                        interrupt-parent =3D <&plic>;
                        interrupts =3D <5 6>, <7 8>, <9 10>, <11 12>;
***************************

Thanks,
Shravan

> Thanks,
> Conor.
