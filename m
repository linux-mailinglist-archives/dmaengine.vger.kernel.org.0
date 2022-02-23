Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD14C0DF4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 09:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiBWIB5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 03:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiBWIB4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 03:01:56 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6E7806E;
        Wed, 23 Feb 2022 00:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTDLqkO6z2Ixo4ys+C4myjFgHRc1UAjCk93WtZcfZqAppUJL9fsKZNrgo9eWfVwdkC30zo5HmzyHmwleQMz/m3CsLiQN8P1o9qxY3p/6VHEzl3aW0VNxOjJlSEmW2qdgaw5ex2kg9xIiM+mPP9uZeu25iNXaU5Rs97Eh3F5OgTE18Kswq3QUk9+j3vTjxmD9Gk+PgXPocuaH1H2wKvfz3w5jd0vocU5QnNhX1yqb2w1DPS2hUSBltDv4dhaibOw1iAv6qEUH0DA9gQ2sZ9+9jo1gZSznjd5YUxLtgLPNqCruLRDJxs0Vx5z4GVJs+zXy1z32XAjwpsK//rFBGdtx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhErETsq9X3q3GpS610GcVmFFBPmZ3GKzcYq8qujK64=;
 b=Ht3fY+bLkA8z1vZNPBZNpeUSl3yn7Tnkib4fIjomLVKFllOUYcstismGkcuPB1GL7uRhQMpef00Fh+m+q2ue//FfZ3yK6YvfQlnbji7zichx7VBkuGd4nnKEzRugteRWu7va0+sAaWcTxdOhrqwdFJcw4Bok/CRXukh8vyUdMWIW/YVOUXSSxLT/L3yHiE6VyeDdYGf+p/3DS9oVzGPLkT1QBU1k2Lp59uyu39QaBrcNvFD2LcvO7f7hgi0EAFgJb/Q5RX7vyvLAe7jASVc9R8nqDOfNGiwriCmvjoxprqQwf+4TrjUSNCiT2q8WF4TjM70Gy7bbIxmWwwBFTIS8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhErETsq9X3q3GpS610GcVmFFBPmZ3GKzcYq8qujK64=;
 b=fBjxIlPRm/jEpR9mthfZaCeEFHmKw6kaLCvY2JtrMU6/oJXxyZDXVO4xekYUadFK+yQYH98FNRzFkR95GiCiPDDO2F4sEMwq+R1TuYdhJ2GP9usZXi5FIKhDCOEN/zCWDwuyMuMgnCQ3jOZSV1ukSplJ79zf9/HBML/sqEh8tRE=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OS0PR01MB5634.jpnprd01.prod.outlook.com (2603:1096:604:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 08:01:25 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::176:c92c:a852:ed2%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 08:01:25 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: RE: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Topic: [PATCH 5/8] dma: dw: Avoid partial transfers
Thread-Index: AQHYJPMfNzaMXGg9ukOz8Sma94IPu6ycRUGAgAFkUmCAAJN4gIACiUJggAAGn3A=
Date:   Wed, 23 Feb 2022 08:01:25 +0000
Message-ID: <TYYPR01MB70869A99001C96933FCCFD36F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
 <20220218181226.431098-6-miquel.raynal@bootlin.com>
 <YhIcyyBp53LnMbjU@smile.fi.intel.com>
 <TYYPR01MB7086F412B035A09AED2037A9F53A9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
 <YhPDZ4yb50sMdVgV@smile.fi.intel.com>
 <TYYPR01MB7086183461B9343A2301B4E1F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB7086183461B9343A2301B4E1F53C9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b67dfb03-4d6c-4eaa-db30-08d9f6a2b09a
x-ms-traffictypediagnostic: OS0PR01MB5634:EE_
x-microsoft-antispam-prvs: <OS0PR01MB5634CC9236C051D023DC613DF53C9@OS0PR01MB5634.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWHieh7AdOZ4BOFYtuuV9QBWwmFvrrXrVZ4Iq++XYgUpwXseutWhO+YVtKwKL1CWoXOtHsvRmONMc4bi78KL7KLZ3K3fxgJB7EyJ/zsEY9I9edwRFr499gCo9XJLCi///nPnO0n18iVmCupyA0Ff6wD/JFdq1ki5GOUGQ7Qt0WMqH1eT5owTh9osAF6aIyw8HYJBzOd9johAmglvAodYCD5yiNRp20kOEfwUtPeoyJ9j/jS4y1jKfUEr4FV72YwjypCS1Iz8tky/zBlCySi16M/Il9Dc7t8OEPf4kegeRTEHizRyRNnYhQmUSiHU3FhI0nWcj8a/Zl+B+l8LVCvb4xnWuVMITFRIch04jcpqex1grGBahPvbOqXQ/H5zmBRCjVZGbLvBf0UZJzovF60yBvxw+44gVPaK2+hrqXq/ovP5mpKkScJyuMfZKRcYNPkHeskkQqwsCxL2W4QryyOLHqb8/khv4hgY1xHbzmgRL/tcgNthM2CHo7+PzgTiZ8dNaxd6kYtfdhKYskHfNZMMMsHs6FGKugH8ay31B5Q2jhYXIa31o4gmqGkZYqepaeVr9XmEfb3+970s15f5Qc2tit0RrVN5pAuuEhAFz3qJJacl+FhjMBMbMU+gW3WD9NUyVo9FawLM5j0wBicCSuXOmfYS8wayIo2l1QG20rfPTuwwVUbZwJERO6klZxdJ3K0NRV6wSo6kMjIALKzpGA4JuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(558084003)(6506007)(7696005)(44832011)(64756008)(33656002)(26005)(66556008)(186003)(9686003)(8676002)(4326008)(2906002)(66446008)(76116006)(66946007)(2940100002)(66476007)(6916009)(38070700005)(54906003)(86362001)(38100700002)(71200400001)(316002)(52536014)(5660300002)(55016003)(508600001)(7416002)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R84KpQY29yy+Lo4jeMRcbeGn14348vYNmRiHTlgo9vfMyopKp+tzcX+QT31m?=
 =?us-ascii?Q?XYiC/P8jTomsiv5KLzLL5C/X2C0WpEzsTQNOovX2LAkMT/jDsMKXN6Oqg4Nm?=
 =?us-ascii?Q?dydiC/+U6b4lAAIa0SmXPRib1hMSDnD3AwOw8BknwdTIBUbAyY6gdf1O0yIM?=
 =?us-ascii?Q?r/EEj5CS0xgEXX76ugqp1HV/SBDvl+N8O/h5iVKgKs6yHCPQEemoEoMhRra3?=
 =?us-ascii?Q?3Q1ZF+g62Rw97sYKF6LcdmvQxj+dKOkSb2ys5xgLTT80+FeFC+3BKg9gNjG9?=
 =?us-ascii?Q?MnciCRkP3mlLIqAAkvo0koN1f7vxb3iNdKVC8ZnOxJ1zRf9cp10T2BuyTUky?=
 =?us-ascii?Q?SaqAzv6qdvpkfATnKQVARBpZDlUzvMk808oTOb9CZ6M0YvGCAYVp5oohlnht?=
 =?us-ascii?Q?yOlX/3vthXqWqg7xfSnCys9sSaQQcxdwI/iMSpGleN7ACm6LmV3FSlp0lN7d?=
 =?us-ascii?Q?Hlz+coGlal79wES8JuU0kT6NRj8nCu+fE8upXE0kzBi3LIr/UKTVEXGi4xSN?=
 =?us-ascii?Q?DLrbfip5LVj1Ie/UnwFn3nMDuSAmIn9j5++2fvz6y0zx0oOioLWSJr/j1Vv/?=
 =?us-ascii?Q?KXZdCjuX/9JhaXlbJ8NLIKLrFXSyVUMvUUhKWmvQSmOPSHVN354Ov8JbZ/UG?=
 =?us-ascii?Q?2bg84jLweH4Jd0UxLNzGBluHiUdwrda7LQE0BFc4TfhN98Y4AVdcrOrPwv1I?=
 =?us-ascii?Q?+Jx4gPzsVr4jCxopbJDnV6NXLyCEXDy1gUXOEjfaI/OgEji9+Yc+NdYbT0rQ?=
 =?us-ascii?Q?nPo3quNvuKjvBZHRX7HsJ6Plwi6d+72PjLrf0Hngi9/PJOXH66jxzx/y7eTH?=
 =?us-ascii?Q?G6Y/NyZs8su9G5J/hNnu3C8XEmkHnL2J4fy7dAjaJQ9hWssTO+Vddgy7ac42?=
 =?us-ascii?Q?wtNuznsjuo6eYYzosgLuPTIxMMRPhloOmgvC/c1aQlyzcVP6Z/WAGBPe5VKj?=
 =?us-ascii?Q?nwTQo/HN4szUtccp3TQYQFLGngvtHfaOszJ9cGuu7EgiUdT+RtHwGPC9fkRv?=
 =?us-ascii?Q?C2By+2J2sdbJGCgoe75OrHqjJsw8SRFiOqTeSQQd7/54IzN2IBhTxOzCmEC6?=
 =?us-ascii?Q?PhaExrn1iZBFB5as1y/uQx/wo6VSlWmoF6C4y2hO1z2Cpsou8KCbyMYxT5fV?=
 =?us-ascii?Q?e4IhTP4ZYvPwuiAH2bGoTkzZGarhgrPHIVsv0X48FuCQJEtE6Uu0FAkLmzPp?=
 =?us-ascii?Q?LumgA38EwXx6Yz98m9NMKlez6Noujt/oDs28dG2Ox3n8w0LLch7oqeZwbiQ2?=
 =?us-ascii?Q?+vAm+qxIMCfX8L/xVRpWSFZjtjomgCkpserXQKaJxavhwixGqcqWiSqMeDtJ?=
 =?us-ascii?Q?HdvU73DBenRlcyBYqmSWFg1THzogRIV416Um10HA0lRTOzAfs2Ddp3StGW8C?=
 =?us-ascii?Q?UnpUAlfF94gLVApbwz8HjwUw8KcpXRgkVWAQYzFT25tjUu8s0wT77RI4mE6O?=
 =?us-ascii?Q?sAL7ELrK7EYwyIZ7JPGBn/GDOTc2hBNtLTGcqdDblPpeE0JTk3C0tESP9DAj?=
 =?us-ascii?Q?Lpfoaxjh3Mc9+1tsLbfmrfcJDlT45mT5QwdVzLufNW7nLkKVfq3T1kag8nwr?=
 =?us-ascii?Q?ecZmwTW80EiVkrYqlv45EH1uJB84nqahsUXq4UFWvTADIG4X/ebpm23v2/ko?=
 =?us-ascii?Q?YkofEj6QrtpbOOjVuUUoelpTmq1Ip0gvpvWWnsd9lFAKk4ivCz/rhVOBer+w?=
 =?us-ascii?Q?m2nveg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67dfb03-4d6c-4eaa-db30-08d9f6a2b09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 08:01:25.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5fphq/Aim/qORB4/jt4xOSc8GImiYbIySbUOCiH0SUPCwjbUvj0Qu7yTse5rvrUpM+gUvx8Mv1Np5JLvN6yvlGJ1PbXzgCRcfx6dgGdlMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> > Also, which version of the DW DMAC IP is being used in this SoC?
> I'm still checking, but it looks to be 2.18b
Our HW people have told me it's v2.19a

Thanks
Phil

