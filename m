Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F1605A04
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJTIhA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJTIg7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:36:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367B107CD5;
        Thu, 20 Oct 2022 01:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrvVl6P5NWk8Z2Vsxux7Qxze8vKd1rOqPuEePU0bYIEen9IVH9sHZpFpgqYgugzOJRx7kKK6+erdLcxZoCMHHTWHCf11GUhkv0sjRgs2RKs5PAd7OplAia6XrK6sNRt68kAYjfL4F5YC8bRr+PKmQdIFBePIw4dRHSvFG4NeM068aLv/gxiNsheAQqZGfTmfyfk0885M54gYQzBDX5fhbazdIpTk8QGrIVJGMns553TfFZIBMk3oDQwPbTKNZrUCbVUSxVPfinnvwzbIjzvqXcYBBTsalC/gShJ+vAGTHPSocrrS3tdKjYSeerK5sUrbZNjspgVpx5Wsh274PdK7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiwiJg6vVHof0spIFwFmkJrWgUwY18jelyLHFzytQZc=;
 b=HtKPIkSobSP6nluRLX77SPAKyAexSIFWC95N4ROdcw9X7/MMciRYgtMVL5eLD54TdyScuPThe0Hvn1uCml+nqR24kDlrGrVnh27wQ8dG5ggdTzo1JP3tG6kGppNeqPc7R0eutu+qsXqgDvS16DjZ6VieAvsuaU32fuLLQPeJ66gweDVeypf6g2USDy+t0hJMmK5LWRjxmddpxk+oTpM0yC+8hVZftFFnc5e1CfY1uoVdKDiLvT+E4meybS7Bgzzr/UhA+wNs7M5tkCXssA8lsIvFj4slZkYLyGkUStwO6GFpdi5wsOaProR0S/SAQFWn58eEaA0T9x3GgwCCSKB9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiwiJg6vVHof0spIFwFmkJrWgUwY18jelyLHFzytQZc=;
 b=Wgs4NAPya/Rk23di1iQHAmbMxl89uCnatnDLQnRAr7FLMdv/pyvQ0V5l6cgzOYumIdXzNrOck2UdjJi3Gsa7d2rAQGIM3y0ptwq2XGJ8x+Pr5T9xvbB08/TDm3+QDbFv9gMipnZAWipE4CDnoFdlf5XFhZ8WWdFCJCeSvCAnwzJcINjx9UEZ2bzRG8QVu/KKJGVuEqR37KDuTJriJOHqiP6EUjG7TyuA9hdxMXLCX7T7Fha/bnZb/ivAcgLsf8KqUqz13mYESFqn7K5I5ARjj4x1Yr9Z03byKvjDWblXCz39ZZ+CNev2YuZeHZbwmd2Cc+7KHBpmS8C+5Yzx0BxFyQ==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 08:35:49 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32%5]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 08:35:49 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add
 dma-channel-mask to Tegra GPCDMA
Thread-Topic: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add
 dma-channel-mask to Tegra GPCDMA
Thread-Index: AQHY4w60pM/XOrLuTkOFhMuP+s4LmK4VuH8AgAE/C3A=
Date:   Thu, 20 Oct 2022 08:35:49 +0000
Message-ID: <SJ1PR12MB63391BE6FDD534E5FF215425C02A9@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20221018162812.69673-1-akhilrajeev@nvidia.com>
 <20221018162812.69673-2-akhilrajeev@nvidia.com> <Y0/8jF++NeUGtPGM@matsya>
In-Reply-To: <Y0/8jF++NeUGtPGM@matsya>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|SA3PR12MB8021:EE_
x-ms-office365-filtering-correlation-id: 411a10c8-e63d-4f25-2657-08dab276177d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dREjr42a2D/e0GDeJuRWkpY6M8AxZRIQxlciSdkWEI1NLFHTchsEdPfOSIJMuRadWaTvhaZ8WBd5mhL/3dMGMGXZnTSHNIaCe6uiNfO++l6p4jdwsgRBkPaEwsjAhAWc7HaAmoFE6pj0zDAFQu8DVsYCAQTRfMD5ATeg9UskeMRiXaGUF3v/j+Eh77NEeVGcc2YLeHI00/aKM+pF2nTjEM2kvEiQsD14qY6q81Fqefg49OJokBdXulxTew7rmP06y8lyMdy/QvwW7Y7JC5AuJDi+5e+6gW+46Ag2KiMBNobQpifKu0jGFC/WDVw7L7GBQ+8B3GyrPgJbGLMajKPG7+BiX3t90ZTcJtWCgGZ9NWXyFwQjxUZzlKD81+WJSvH3mnncBfZgTsjin18aNwQrZeMRVfKQ759cXSJdzP0JfBVnzAFmg9eM1h5tQ5bkudSrqbWD1OGtafTIb0wfetHcwgE2QprYXKKOg7KHIf/6e9/HktZ+b20x4hU1R2Z6iGrp3r2PpkI+7nY26HFE57kuGv7CmVKyguozrT1y14imDfC52IafGiHBr9FYA2rCqoB6hOkc0zIrqUXhC/kDVsHO3HQr699jDICF/LLVA+VH2tW9pZg30qo1/vlEEPNjuVN/K7eF/JFca2izu7qpMJ1hWhCGo475KTvsl4b5H1j9ZrZnvmLhYuV93nfTjhG7OLswht5snTk02tqX8EYx5J/RbSHPa4wByhndZBcYxjpPkNKEm2F1plkvvKBpqyP1OTga9xIeNCcdaMc3dnXzJzQtPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(8676002)(5660300002)(53546011)(316002)(4744005)(2906002)(26005)(64756008)(66946007)(66446008)(76116006)(122000001)(7696005)(478600001)(33656002)(6506007)(52536014)(8936002)(41300700001)(71200400001)(4326008)(83380400001)(6916009)(66556008)(54906003)(66476007)(38070700005)(9686003)(38100700002)(55016003)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06ivKOveGZjZs3yLsEvi/ogVkhIQjSQ9fQqe1Nbmh8eVJNjGgB6q7Bo0yTU6?=
 =?us-ascii?Q?1OGrfUBsicLvC7Fb3AMFsNQfxZLfIbXjbyy+zXgYSwjq/58YJES2qjWxFb8K?=
 =?us-ascii?Q?2DOXe8banowIqoYdUNzh0mq9CU3y+7nsUGfZPfIqo4tVW7WxZCvM3OSQ0z5u?=
 =?us-ascii?Q?zVBANqWiH4z4Wy/LVdSdhDHIJrDRv++VHHfJsMOYeGaByG7JZ8rTPT5MuILz?=
 =?us-ascii?Q?oEk8bxH5R/hkW0OD6ldNmLizMWLcYwoWNUg4ct4aKWVG5nBacfEKhcqooWFp?=
 =?us-ascii?Q?gYoJq+qNVeVZSZThxB/0obQrpXK+wtc36QPrvbbp9tfgDgKlGxMd8UovFEad?=
 =?us-ascii?Q?jyHyeS5SQ3t6sTbTnYwhfGEPyxdrdZ2PkzXVYtrv7vUOylQXXCgAgeCe33NW?=
 =?us-ascii?Q?VdUjBA/93XCgUB7/Oy124sYLaU0jns+OBQj5+P1KGaFp8ndvIPMMKqeMIn1x?=
 =?us-ascii?Q?DSDWssbm33ff74vSkt34XRhqDdH5MSLSZ2wyUaPxNSt0hWdHL+gllYtdOYLM?=
 =?us-ascii?Q?yOWKTOACtYXusYEbpXfzyePo2nPFzHwixY3CC1IlR6AsCTnq+xk7idCaLeoW?=
 =?us-ascii?Q?xlZ9Kj173ukhdC/rQnVxY8zwc5EsIjK8JhN0eLQEtk4AZuDBz48LVAxkjZ++?=
 =?us-ascii?Q?eqG2pdSmXffNJsEnBXeMkvlwwruMcDPGP27t2WRVx6eUdE1RSel+z37lH+qk?=
 =?us-ascii?Q?o985ygi2qTKiv0JY88c/fnjT6ta95WX/auoQv1ys0bXceG2y/UwreE4AjFGa?=
 =?us-ascii?Q?dAgqn1STgnujCOmX7J073cstBCj3K5JA0ETm4/7MGpDLQ3+jOCsAHf0Axz6j?=
 =?us-ascii?Q?W9gXcPGgfQgskZatADoEp5qZimRzT09qNGbDr9fMweVF2ABsVGOjOUj/16SU?=
 =?us-ascii?Q?lpxFYnDu8Gop8JS+GeReh+DA5Cg7RN2E2OLvmSDDGN1nPAz0015P4jpF+u+k?=
 =?us-ascii?Q?is6wL3jdSbtzvkxBIih3b0QI+tAK4W+opBk1CclJ/dn+czDbFEiEqEtnO0mv?=
 =?us-ascii?Q?jKYwA5IbC9Fr4PnCHqyyGKEPUiPKtG5t2sw5NJk5vg4D9Fy8Z7DiLlHwjXgr?=
 =?us-ascii?Q?qoP6e78OmW+HK4DwIg9YqyPJPsOyUihpBG4FmX6M5fieu25HK2MMycxRGk71?=
 =?us-ascii?Q?qCXHf31hhQ3QlHUtNEb+hnHbsNQcew6mkjLbuqzeCaxaLTSI7XnK8eOoU98r?=
 =?us-ascii?Q?+1NMgVNX4DP00ApQGhJ6xwlqxb23OMyFxUsPvAmGF+bpLlJuwBJJEgGtTt+I?=
 =?us-ascii?Q?2KRyvZ/Etds034g8BT4afmj0mYh7cWkEQNAdogtIJazxACt4bCId6ffhCBun?=
 =?us-ascii?Q?F9ScNcmZodKMuKw0I5bEMEUH1pwRpUVhetD4kdeXc58WAdITQyDCcUenb5IA?=
 =?us-ascii?Q?F2aFUurGfKCWFoYtdaJ3Fh+vYWhfnUV6yoJTa3GuIUncK5wAEo5MzTmQ9Ggc?=
 =?us-ascii?Q?kt6vOzVzkF/p4yN/zcyDyhz+8mn02jZJO0Y0jsD1EJr4pcb/5X//m+3jPeiZ?=
 =?us-ascii?Q?4ieKxADfph6iIOiReCD6VhHKioRsBp89pr1VDRehwLAVOamEAcusr8m440wm?=
 =?us-ascii?Q?BHt8ZnJ89sKprRRAnsMuKB3jS5TxZCeD2pzTNmx2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411a10c8-e63d-4f25-2657-08dab276177d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 08:35:49.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhIKg0jCmHTQhI3KLY9Cms2BFZOCi0sDrt7gDQxF3Kmlmv/9+Zvi2FrOeYKYR1F44j/3RmubJxJt2n3qzOhhkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On 18-10-22, 21:58, Akhil R wrote:
> > Add dma-channel-mask property in Tegra GPCDMA document.
> >
> > The property would help to specify the channels to be used in kernel
> > and reserve few for the firmware. This was previously achieved by
> > limiting the channel number to 31 in the driver.
> > Now since we can list all 32 channels, update the interrupts property
> > as well to list all 32 interrupts.
>=20
> Pls cc dt folks and ML on DT patches!
>=20
Thanks for pointing. Resent the series with DT folks included.

Best Regards,
Akhil
