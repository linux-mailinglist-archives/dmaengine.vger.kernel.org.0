Return-Path: <dmaengine+bounces-7247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214CC69B5E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 64AAA2BADD
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE73587DA;
	Tue, 18 Nov 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="K3jqY1EM"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BA3587CC;
	Tue, 18 Nov 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473811; cv=fail; b=XB1lTf482I2B4E8v7xXVM3kuVF7szL5SV7s+TUz/fofRMnlAWUK2PPhyiJp+jteKOeZOHmSAQZuTQ71V5RDyNcrRYTBzdTx9bfEzxAc/Tr2L7sb7pD16KBrJC5cndxiUpxS0Opdd64ngsuygxFP/t7pghYh2c7k5n29Fl3cxyHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473811; c=relaxed/simple;
	bh=C41yqYQqGAv/mzxuV4+QvJ4kc1zxs9Nd0oscv2EyB/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXRgmkq482sFJu7RvEDisZpXv+AW3AjJDB2xcgRzxRo7BcNyAfUPQoohr0bESwQcTgLfvtjs0kz1g57DzGhP3EHeExCnjM9jzo14yGbWa8JReqpE3tI0CemY+PQI7FOpTtbLhVAFqngfGo9LRmHf/bzEp9FqQMX+P05gGQ1qb78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=K3jqY1EM; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqLBtYtgFTm6HwSpAIrNbdkzIXuWC54CRcs1FXIXpyY/yl4IELHC9aFtEuspWMzEPx+70DASx+lJ986tHqWWYWMLn9HtAwIT5POmjDAmSVtgBe2P9VkdVKATXJqOfQndVLVK4UEsBnvy2lq2fLadj86rcLv08c7ngaSLse5HdFV5EvpGXQVN9HscOqvjyT/khQiBBtwPgSsvLv5E579GuAnwdg6oV61P52Fib/AcCUi/xquUD53Lg0jSm41sgy/uBAIPTWUPga6sX6gOfHbTRAYJyUXDI8sGWh5vGarXMbhAu9SRhojtzxkIQ2aPfNax/XOL7+J3Opfbi1UyKJpu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTmeGEcN4m90IfTn7vxY0pDos7LuLJJTiK833rVGs3I=;
 b=xbG6g+INVrka9oIFgp8TT2ClzEwaxw/gwqQClsgRCjpthSPfGi14loE5w/jLHoSshiKICSA9Xpo3b445e4wpp8eTZj4uH1B/HGuKFMyJtqZuTR2a1joq7+VPmhSiozp/KXisFo1MJsWZ1bEoiYmk4cDjIyK1K2FIowOZph6G8lFOki1mO2G0GU/30ml9LgwDRT/SJJ3wbBMxv5sJaaaNdQfcnypl9J4E5vDWR4INAeKs4FYqAzez6r5FeZdLKdnk/WgkPGklzSst1PAJfgzZLZ7Oy+cuNH3F8sl+JA56Gd7w6rzbwxOhRzwjcCiUWUmAz14RbXaQ8dA/DOiZ6zx4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTmeGEcN4m90IfTn7vxY0pDos7LuLJJTiK833rVGs3I=;
 b=K3jqY1EMQO1a9eBKCv0YGQcm3lXyMQSLWZIRgBUKY46/xSDzzCNkdB0lgeKk7eh2RvSvh52/MBje2100w7VnI6AWlY1Bhm1Gekn7Oypo+jAq0PU9Gr25qrMu90bnORNxwSIVZM+biyk7UUtMEvzGU1KbtFcQgZrbgglvjU+bzr0=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 13:49:55 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 13:49:55 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>, Viresh Kumar
	<vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk
	<piotr.wojtaszczyk@timesys.com>, =?iso-8859-1?Q?Am=E9lie_Delaunay?=
	<amelie.delaunay@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Peter Ujfalusi
	<peter.ujfalusi@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 08/15] dmaengine: sh: rz-dmac: fix device leak on probe
 failure
Thread-Topic: [PATCH 08/15] dmaengine: sh: rz-dmac: fix device leak on probe
 failure
Thread-Index: AQHcV90d5kZo2bGFA0qREXcrW7sn3LT4dKZA
Date: Tue, 18 Nov 2025 13:49:54 +0000
Message-ID:
 <TYCPR01MB120937B42EF315F79D0F55B8DC2D6A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-10-johan@kernel.org>
In-Reply-To: <20251117161258.10679-10-johan@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSCPR01MB16310:EE_
x-ms-office365-filtering-correlation-id: cd4fe25f-d37e-4d4b-b8d2-08de26a95af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dx+PeaNNsfjgHmQcECeQdHeb13bH5t0K4AZZdi5N7q/AjhyV0gxcCNl/fz?=
 =?iso-8859-1?Q?tzcD1tQTtsNhrScknR4+wKQtPZ6P99mBJ6d0ttcfH4EX5hxY2xQLQEq7X+?=
 =?iso-8859-1?Q?nB9WEWJmHLYp4QOtEI035pOmdtJLuaWWFIKL5bupPYgKoXstsI44M+8bgv?=
 =?iso-8859-1?Q?xPI+u53J6sp/pPljRozh3uBeTfIt5U7b/F5tgdlT77q/DUqQKTl8dJgpi8?=
 =?iso-8859-1?Q?XbTofL+Q6yggczag/FTRzgjxcMW0nIKhWKc+ggq2dgYkeFwDM5xN4552K4?=
 =?iso-8859-1?Q?ftVtBsNPAS39tC7t3Uqa1UG6ynTGbQyTBpL2VReRw315o9Fd0yByYk603P?=
 =?iso-8859-1?Q?4MDKt7rBZ2fKQdbCu8z1PfXO/3KLrfkc7qP72BdDJo6mIzc1y/zbkOPOcn?=
 =?iso-8859-1?Q?xGX1TDB8onJB2gqey6/fbMC6devgxblfh4gGUMwnfPTCymFivg5AADOUss?=
 =?iso-8859-1?Q?r+ZBqUy8orvxISkoC+pd40Ruvay4xvTjR5ikV3s7QwozEbH9gZ3OEbHbuj?=
 =?iso-8859-1?Q?o+aUHXe4BBCO94UMpL3n33nauHY3H1cA5dhUY5FpRr3pT4R534FZscx+GA?=
 =?iso-8859-1?Q?0e/1acutqNWiTaUW9u2PDZtba0W6uguusgtXPMu0XNVLXd0UgnInibleum?=
 =?iso-8859-1?Q?frEItYiqgFjYCahCXodbngbDIoRB8w/+8c3H/KzPqvYrwYBxai9K3EjFUw?=
 =?iso-8859-1?Q?JWc0xtbmh/YivdGSizSHJfSFeUknncJKpQBXLKByttcq+0pl2M7wUBKmb7?=
 =?iso-8859-1?Q?S/fvxwuKKHWGJGUW2u5B4/c963h/PlBjzmJmlkSpIEuC4EyXatqH0ySZ+6?=
 =?iso-8859-1?Q?KTyP88Aq0Sia/oxEkxQy261Pk0gzjd9t2UUu/+MhEg+isPrh6cftTpaNHv?=
 =?iso-8859-1?Q?ujWPVjvOkiPBS3akzPwXYZR/+43zf6WnbLVFKtN5d97uefs2ROzY0OcrSr?=
 =?iso-8859-1?Q?IYXMyaj3jUQWnUmw2mXBTNFMr++fj8uklgvK3XmuEwj3/I2iCwbkDM9XMU?=
 =?iso-8859-1?Q?SX1pZC1zYY9xpKXNsv2+e+bLhmwHh87Kq4GOUX0+fmRiAOgOiK0qa2v/Q3?=
 =?iso-8859-1?Q?Jv/P9PO0Poxj/z/zybvRmXqa2oBLQ3DdhPvGFVJoWr1xHrwkcUPbIzHtYO?=
 =?iso-8859-1?Q?5aiGmfI+JOrNm7s85sjdpRpP5vImK32xeuYtqXTqdIqVtVapzfOIlOrm6F?=
 =?iso-8859-1?Q?Quj1JEuchRwhRNQSz5XG7tfWSdmiRjGUjyhGYlLPDvSSf7O/h3eUDOdWra?=
 =?iso-8859-1?Q?a2gyefsIicxtHCAismccBNye9hGh1tCB7bAnp25KAN08dSScRAB9d3zN7e?=
 =?iso-8859-1?Q?SYqsHmFIyRb78Xu41EbQCKT7cjddhVgld2Ik3DnFFkVOhun0h3WV/r4r0Y?=
 =?iso-8859-1?Q?H/EY9i/pw/xmKLzVuJgFlFT6Z72w/ZUR1dn0yWY0LDN3MEXRiWEyKnarb3?=
 =?iso-8859-1?Q?8z3bvam3eqRAHe2CLJHKPyKOHJXNrcfy7BoYs4iAUmLxqlirjXH6TEc1ED?=
 =?iso-8859-1?Q?3zjZfNwSa2iNVR/pqT7TqVQwcwTp3onFN5aICGmWiSVmOeOF22OI5sJb9R?=
 =?iso-8859-1?Q?OmqxWOfz144/hAegVLmpJHj4OIuy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I74Kjq/UzY9yS7kvLXmgPcAeJ614d/sBVX48o9lfG5rMAEDUMFvHyDop7k?=
 =?iso-8859-1?Q?7nS0JTyx8Oa1F+Pax3wQOMd98YOXCEiopksT0gLQpdVCTSnEYGR6nSHCdl?=
 =?iso-8859-1?Q?YrAZvtEIuhdym+ibhunqMkgxRLhyAnsrnfVw9KYizJ1aVeH8uHdKYbtITU?=
 =?iso-8859-1?Q?6O5eRCKRiZ87D5pfiD1E86d9SmfMSYayAx3o4567gbgEMjg1AAz3+jx/+G?=
 =?iso-8859-1?Q?O9gqKTjhLoFsTsX5L1PwXjV7tOtSZleJMqIWnnla+b7De4pQWahO+mi22T?=
 =?iso-8859-1?Q?+ASB+sMDk1x1cilEVguIGbWsxDOZlQOCvmFrPVGjtRIbNv0CAUViUe1Eeb?=
 =?iso-8859-1?Q?UCKkJHXpExzqobR+DnQ60l72d2MMx7bT8ELS4HhF+mZ4VeSv1XSt+cHH+N?=
 =?iso-8859-1?Q?jWKYg/bbmpm+WX/HaM4nDpBZCMoFCaVIsC0liWpJb8jeARd9IKq1XF4SvI?=
 =?iso-8859-1?Q?/ep34OUKeeSIjTIy3BLIf2QKGfk06Lqd4K+rL/aVCjG9BxFeQ4D+D/L7FD?=
 =?iso-8859-1?Q?mM5wQzFUh84pPmXFOxS70f1cTDo7qYi6BYSNDOJUI8Tfr/aCf+woa/LltQ?=
 =?iso-8859-1?Q?m2tUkNa2j4P9/7TZDTLYi3+AmG0e1D7sSzgfevMbfgyh2fLt/ElI8apHuw?=
 =?iso-8859-1?Q?lX6ugVkhmkTTYK77RKatDlWydVIlCfCJdXHfmtXvyR2FRPhNqvaHUvpj8E?=
 =?iso-8859-1?Q?1IsMzBkeceUqdiY9/0BYQ0aMzsYEmAjouppdoAEn5UbsHs8EyY3ObArB3A?=
 =?iso-8859-1?Q?aTZ7Ah2d5AhmZkfxCpVEboWX2SAKHmL60g63EX4ZFXHn3KLIhjlauaBhiz?=
 =?iso-8859-1?Q?GPg+yNEAbHYJuv7pNFLABfEPePR79vGvQMdYeqTYR5U6EvfxA1/z4/Zb/X?=
 =?iso-8859-1?Q?kZN5aprQEborbCBrMI0mfajX9uqV9EqvPJ6QxxWb9c88oYbSGioFLYnvwt?=
 =?iso-8859-1?Q?HjqOpsFa6dUE4BzuNE/dR+zpT7CXgroNX2tHp5fKvOoymne8ITLInJntR/?=
 =?iso-8859-1?Q?AwER3uXZCPLzDowu79w99ef8kZ880mHqxICCTSXLvHgDyTyo/f1kIC+wFw?=
 =?iso-8859-1?Q?kKlb8ppt4n58c7qlXT0zPbtajgPm9K9X4sSRpqvUEpifEGZiz4yOrsJ1Ed?=
 =?iso-8859-1?Q?KeR+I3HU9Us57vq+RsviBSHE8ymp/vZTOEda8UBzB9L5afc8sw8Dfc8oWe?=
 =?iso-8859-1?Q?F3Ui7O23gymVkxJac4K6mtkCVWi2JMnPw8p0lHJMsRkx65brARUMOflxsf?=
 =?iso-8859-1?Q?aLtDFMMmv9YTcTYrtY8eA8rTa6Cp6AsZmrM5d+8eQEaqhUZ0RjUMnvITl8?=
 =?iso-8859-1?Q?H6uQ8W1Tv35eEkCaHhdjQg+84tVLzZejT59FJyHn+vQWUpJ0q4rraF0gH5?=
 =?iso-8859-1?Q?38rdBWmquWPxRjDVBROrxkeNmg/WT4WBFOSIbXyUTJb02pADW/QWz7+mhd?=
 =?iso-8859-1?Q?n+UoWAt/xqzFfOw+iuRTNW9xsf5euGp7IlkJjQEgfznea/35B8BcUVCRg+?=
 =?iso-8859-1?Q?QimFkTF99PA8KQl5tNe+nY/5pjJJUAaum02Xtxp+lYxlV3guBw/6EB7bca?=
 =?iso-8859-1?Q?nRPYZpTpF7aGPT2/6GG0fS6fzKzdmHgNvQbIItUu8ww7u7JDuGqz9ApEo1?=
 =?iso-8859-1?Q?mVws6jhgv+rpz1IeUhVQRHxOJl/+9Sjkbgz1qtvDd5pmoSmAdw/PpBuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4fe25f-d37e-4d4b-b8d2-08de26a95af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 13:49:55.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQ+/sbXJtekvRj7MmlsKf7peFZWEzutdmO79+alw37W4Co03QXR93NizUaZAEElOZcEJe2iZnE7EaOs+0aad8V5pyI6TMduEssqdqZ8lKes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16310

> From: Johan Hovold <johan@kernel.org>
> Sent: 17 November 2025 16:13
> To: Vinod Koul <vkoul@kernel.org>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>; Viresh Kumar <vi=
reshk@kernel.org>; Andy
> Shevchenko <andriy.shevchenko@linux.intel.com>; Vinicius Costa Gomes <vin=
icius.gomes@intel.com>; Dave
> Jiang <dave.jiang@intel.com>; Vladimir Zapolskiy <vz@mleia.com>; Piotr Wo=
jtaszczyk
> <piotr.wojtaszczyk@timesys.com>; Am=E9lie Delaunay <amelie.delaunay@foss.=
st.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre Torgue <alexandre.torgue@foss.st.c=
om>; Peter Ujfalusi
> <peter.ujfalusi@gmail.com>; dmaengine@vger.kernel.org; linux-kernel@vger.=
kernel.org; Johan Hovold
> <johan@kernel.org>; stable@vger.kernel.org; Fabrizio Castro <fabrizio.cas=
tro.jz@renesas.com>
> Subject: [PATCH 08/15] dmaengine: sh: rz-dmac: fix device leak on probe f=
ailure
>=20
> Make sure to drop the reference taken when looking up the ICU device
> during probe also on probe failures (e.g. probe deferral).
>=20
> Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

> ---
>  drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1f687b08d6b8..38137e8d80b9 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -854,6 +854,13 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	return 0;
>  }
>=20
> +static void rz_dmac_put_device(void *_dev)
> +{
> +	struct device *dev =3D _dev;
> +
> +	put_device(dev);
> +}
> +
>  static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac=
)
>  {
>  	struct device_node *np =3D dev->of_node;
> @@ -876,6 +883,10 @@ static int rz_dmac_parse_of_icu(struct device *dev, =
struct rz_dmac *dmac)
>  		return -ENODEV;
>  	}
>=20
> +	ret =3D devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pd=
ev->dev);
> +	if (ret)
> +		return ret;
> +
>  	dmac_index =3D args.args[0];
>  	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
>  		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> @@ -1055,8 +1066,6 @@ static void rz_dmac_remove(struct platform_device *=
pdev)
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -
> -	platform_device_put(dmac->icu.pdev);
>  }
>=20
>  static const struct of_device_id of_rz_dmac_match[] =3D {
> --
> 2.51.0


