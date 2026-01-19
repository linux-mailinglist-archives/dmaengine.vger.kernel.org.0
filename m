Return-Path: <dmaengine+bounces-8366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF7D3A272
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0212F300C0DE
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A735295D;
	Mon, 19 Jan 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lub7zu7r"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDC33ADB9;
	Mon, 19 Jan 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813756; cv=fail; b=cAItc4kmqYKddArsCN7zfG02WOac5BAOJVs+VRsg2YGTVVkb1QMLvf38eFC249LxvXuDZj2b6OD66YhDoSFM9u3+WA4yd7J7wJue4UG6WpPnQvbC/QFe4n+FQgdi4QNzqtGD3v63X0wXokvC+EK0QEcIWqI4M+BNS1AYtvWtXtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813756; c=relaxed/simple;
	bh=SPwNWESu/17nK7dOQsQZxDMICTcSMdHPhGpWinZfV/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txtiulX06G0W6f6ZVBcmomZfa0l1pqcmK6tdK2BS0Pn/zGMhXSnYTJFlt2A4jGUwVqIvXqUdqD8v12J69n6uhLyq5MeSfMxIC5Mmq3ZvNyxKeF83M39vJHefbpOXX2t2S7TPIvCOlMjitpI1QpJc7sraAWaSX3VjFeCS4hSv/PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lub7zu7r; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNuYCG6LUY0c1kptCkt1cus5vECmp8BvLVy+ayed54LWkaJDKATi+b+qox3c/6zdIgHcyi07PqMKjS+C8S9iifgFmB3ojZZ7+pl+CXLrIZlfhuQPQR68xAxSTS9udX3Onqs8VswazB/H2QYy6RLJVBao8Gg5uYXV/++yzmKp197uJ7u/vJOtBxP4fWNMbHrJrGdyMqLIUWuAAArblF5asJdnW0nLgI5s3dEedp983kARhVClGKKK4KW+N7sICE3ElTwepHqMJ+WAEYotWrxwEAAoPp3yZNScDkWP9kgh8MdrCBezGKhXs7Gqmcfl1ZuOZ4ifp/1w/QgtdmTJcJ+dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzpQhWV6lkVoblfujbuIM7W/IVIp1jtm0Lj30Cl12eA=;
 b=NAz1YT/ycMU741Yc4LGepUTYJsSFWpwRyLpbHfuOF5mBvMxtFKvUSVcWmz9fLSWqd7v2JqzIHvwh+PDhDkCgt+RKig+VepkgcMYdcfrLA1caqJGcusjN2icldSddxt352oT/dVYPXX7nbk9DnPwM2Xo4PET2XaVZNmqvoFcdurHkFmV1+ayyviDinzPu2puvkScEHmieWptEvNP2cza5SowZJ10g4KRcxqchvouxGnWASGB1yyDzUorYoWjlic4ktYeFIykEdAvXo1WNsux50Hbdgwc4rPe5/7m55ByHmFR+Yr3avAGlDdPFwtCSVVPqm9g2/Z0pCSufpGXKV7aNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzpQhWV6lkVoblfujbuIM7W/IVIp1jtm0Lj30Cl12eA=;
 b=Lub7zu7r5SivD3pDagTL+/bZAdFoQKaoNROywabJOe0AosqoVhPiz3g2kdicqEtUVXb9T8ocY7estQo4xR85m0nbsh5iG/lEloVb0VLlc1Q86BLfn5uhFKSCk7vTvO9IOOjWGE/0yaBMcNn8/f4M+MT9sjHVpI5+n9eW20TZvv0=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:09:11 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:09:11 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcgWARe54h1fxwa0KhQPOEEiCB/rVTczOAgAWkE2A=
Date: Mon, 19 Jan 2026 09:09:11 +0000
Message-ID:
 <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
 <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
In-Reply-To: <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-19T06:29:49.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: 2d022049-257f-43b7-0eac-08de573a68c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3Pw62EKOoTWbJwuoO6XAE2p8CLbtINs5A9l6ujOhXCcnmhovsXUJe6o9k3Vg?=
 =?us-ascii?Q?rfgwzmZ5QIaiD2+OZQl+PZKKRhUbx4pdxBGi1yY9pDICQNEmH3ITmQ/opbHy?=
 =?us-ascii?Q?ubS61hRgF8KGc+VgbBXjR1XQYl3L4s60PwXPwN7sLMVsKSbzzhZV8AbN6sN/?=
 =?us-ascii?Q?gehwxfhdGQZlLyR1P3rE8XGuxqz9iwgwYMFHOHFZ1O/1kbycPhDutpo5D8pf?=
 =?us-ascii?Q?SPqBemNY+RPM1iXaCDJik7WT0h38rVTi3TPc6uSmq6+NVWTlk974sKDNwY3v?=
 =?us-ascii?Q?2hl2hsHT19/7iUVn8q65fEbToFDDQUaV9l6l07ZQOgtMSlSSgRTAyaL5XZFv?=
 =?us-ascii?Q?dhUCMHupDVFF/CjAAM87dk6wMLgSAJHoPh2y4aiEf4oGifvovWe2MLjt/fpy?=
 =?us-ascii?Q?3g5O8ci5fROewGfl1oNMSZTZ97/Z1UMtPSVEUx40xj/cuKY75JUY5SyJ0Bo/?=
 =?us-ascii?Q?Y/1Is5HFHsKwu7Wc/YWbE11N73IZjIJ9PxPmvs2a8bwXNHKQCZbPzTI1/ieu?=
 =?us-ascii?Q?Lnt+vmcDj1CqGJs4/PJCtx7vfLd3L3pkHdzKOssuRqLXcFjBgsHJHMbGBKlr?=
 =?us-ascii?Q?Mx0XWrEat0O03bnPZFV0XKNlyN9hOfOOLCZPwfANfOureOgLNGU4Kxhtx+XH?=
 =?us-ascii?Q?1FZiKZTK5pXhdJpIthyZ0Wlq5yYPRjHV3QwFbocMv2J39kz3lTv+rE8CVXLp?=
 =?us-ascii?Q?WcVXMZFBidKkbTWVrIAaURc1j74TKEPt29nZRvF3DmLfnupjulSR5plvaOmm?=
 =?us-ascii?Q?/KnpvjArN1eK0rtJmsbOG/NARgjHe1NJ3XqxZcQU4oAqPNHejLNWTxJMWTaE?=
 =?us-ascii?Q?qKXsDVAGnLx5yI4iHusZijZQ34R1sWVo4nb339BdwG0IHgIO3gCTET9JFjnO?=
 =?us-ascii?Q?pPHc0wPChgY1mmkI0GsW/J8fKnbIpfqkA4BJfxP285h8yZz3Hm9kd6aOvpGQ?=
 =?us-ascii?Q?Z3HajgGyrKTt7IHrT1arnnqZhhpp+U+CeNgs3EobJE7VjZ48BxVaycObgLr7?=
 =?us-ascii?Q?rsTRWO5D33iN+7uIrxzUOmbhoce9zZ4mbjLWAjnMTVFLEtRcQCSDErqVuyf9?=
 =?us-ascii?Q?a2/+g+pVaddflNmLxuCdsBjMg8xw+azf6s5Ni3g/A0xipDqTKG5CchEqMDnB?=
 =?us-ascii?Q?GSr++CWcLdXtLw/RiMf+JD3sC+F1pkMrIzZ913TNws7xmhb+KMMeUzEdeuBT?=
 =?us-ascii?Q?GxbhvE/F+VqFX0oYRAz9F1XScE7M9oZCtgGndhNffbe3x050HTFWQv/3H5Ek?=
 =?us-ascii?Q?3dzlhsQdbQzLcmbiRH87OajLyMYu96n577COXS59wTvfMJrWx9rH+wJJ/NOM?=
 =?us-ascii?Q?t6VRFy7jx23kGmAYk6RnFqabZNKQ8PNvi7g2In6UCTmh3y4I1We7Ls8hbcTK?=
 =?us-ascii?Q?rbuuoin+Th1yhx+BzLmaUUhnBazQYLwtHcB9rCz6M+RaRrYLXTp7d7YJQG4r?=
 =?us-ascii?Q?24yIwUIUj3BOJQfQLE6HGlKcfNl3byrcM6ChTSDPFgz2Nn9s3+XWak5QffaH?=
 =?us-ascii?Q?SRvvdV+hp4hkcVdGGqMmNBLwSP1Be3uqaGFRM7+qpp/kkjM6rlIK329CZr6J?=
 =?us-ascii?Q?FPQKxhSZMIXqC2TUgfNImbFM+giRpGBL64/cSqXvpEzFRfWyEd1XcQrlatGA?=
 =?us-ascii?Q?eayYJPSWazdWeO/A5175C8I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/BwFvx8Bp4tgf+VRVfl86moiWyS214BkdSljbTQELHU6bzWxzsh+HCj7Uq8C?=
 =?us-ascii?Q?yh5PCcmgvDfjELxIwlfsJ1KvTeY7udSd5fEQB0AK2ZFrGfD+Xy0HqMFckzlA?=
 =?us-ascii?Q?7xBSsbk/vzo5XiEUHbi5mEUepoJk0x/jyDsZoKWrGEaP3zBdM9crC0rDb8Oa?=
 =?us-ascii?Q?ufs3pmtGWLo/E9meUs9ivTTmcCG0cKrEPg1vI5WxH37ODtyQGWn18KsUc75r?=
 =?us-ascii?Q?ztB2rzL3Uk5ptVb7MPq47NDrH6F8RArtkMxQ/IZTkPnbYml3WpDH2dWTlNWY?=
 =?us-ascii?Q?RorSuaauJZDwPbIWD1p3ucNq4Roz2ssZSxw0KbS71EVEd8xgmPG1UtGD3BK+?=
 =?us-ascii?Q?1qJsRyJ3QWsadUzX4lUGokIRK72AKLWdyR4pkcPOa8J7CtwrPBCcH5yY+LsV?=
 =?us-ascii?Q?5BE+nt/glr/ru7Aof60DjgAEQrD819WL4lc2n7rIRm+tGTNd2j/6cJ+Auvo4?=
 =?us-ascii?Q?U4bfWr4YoBeUa6ojmQpIpGeA2MrR+ugRBoEuiiDzkAjbkEZjrA/vifMVGu17?=
 =?us-ascii?Q?UT9vf3y8FWSK7ldAs0+1YRfwLo6WOiKwKfLksjytKPawl6zM+usDTRTeH2l7?=
 =?us-ascii?Q?k+geb+mPimu8RtmnnYvnUKz6VqmvZOYyW57YhD70fcCbAkLASnBbnC3kwsCF?=
 =?us-ascii?Q?2+jUsk76D7hoyVCgzvSZZjmtMdu26ciJhR/R3xCyXIOF36zBDbiO5fZuKsYP?=
 =?us-ascii?Q?yBqPRmBCcZyzQfjLHM9f6t9lygfMJEBRoWVnSaY3MD5gAbdYE/qtB4Xlm6ZM?=
 =?us-ascii?Q?hz7NKTjb5/zleCFKwnu1wjNBTaUpCtfncdwKrbeOZ7D59+qXaV1vIxA+0Gs0?=
 =?us-ascii?Q?GPychJ42TngdEqH4EtFic7q1C2rIRYPJ7MyhNr37FEZSmle5K8d1keHagQNV?=
 =?us-ascii?Q?JMoHSM+y8Jr2G1qKvMTGvkcH2sWok/TXbj2o60KToBeyndq2XWx2c5YgcH9u?=
 =?us-ascii?Q?vT8B5AIVP0TbIbWAbd2owO79X6T8QMOAnLUwiHjpivbG+dbNO2CS0dDirXF3?=
 =?us-ascii?Q?ZSdJZjVzplRiKR9XHzOH70tVTtLklhmgmjhzFHlAliC2ac007iJnRnRns95X?=
 =?us-ascii?Q?ajo5oGFkKq49BzfPA3UvlQA0I8wFOGhSjsz+PTq7+jUWF570opkAUI5M4IdT?=
 =?us-ascii?Q?P4EAWeH28CKhuBtXKQWrd7cPcTcIdlwVCG61S75S1rSz2g2esXQrqzfS21gF?=
 =?us-ascii?Q?h1djdDL06C6KjbMb60Bs9RGAWXi9XOlHVW2UO+nDhcGyChB3gNPJMR1/Tvxh?=
 =?us-ascii?Q?lgMMrr6jZBdlcVKO7VUq6xSt/REv+5tGHvicjsSy1sjih/yWPr35FRRFAOsG?=
 =?us-ascii?Q?WXUpqQm5+hrjT3mxfaNZ4hYq3zst1Pp5+i8mVbGNh9LGM2YdHxZjHxs4kK0R?=
 =?us-ascii?Q?AT9Uh7XLvwKU0IKI94cOjB6uU/zdukXRRpWdaO3GWJGZ//FttvYrwylKBcEC?=
 =?us-ascii?Q?b6Xm63eIS/4AvgLhQ2cS0XZfreS2b/lmIPqc/u3v2meiLNU5GifzF6EnJV2r?=
 =?us-ascii?Q?oJAt//PX8WORFCbffOQpg/0zID4xcZO0rgRWktNoprqHIndN7/F+lI7e9xvM?=
 =?us-ascii?Q?YIC5Ovw9K7OrqgUOzzriN+AUQ+cYlSKhL3HxdeozWJk8ZQpKQcaoAYj8bmBi?=
 =?us-ascii?Q?OjHfMqiok1VceuEB3/oqaAwBTBa9No/G6+cJALYGJlOEXlE1Qcj3XWju8G3Y?=
 =?us-ascii?Q?ZSXi1mynkAyxoECub+nKFZVBO20aFBt5BMDXGAJUD+F3jWMQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d022049-257f-43b7-0eac-08de573a68c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 09:09:11.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRYUYu6mH4xWs6CyFSSsbaHyFSzcMJuZo5t/zhCLi5t1aNiNbI3ANmG9FSuGpvLFMQEU4vc2TZXi5oiEl4zdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Please check my comments inline.

Regards,
Devendra

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, January 15, 2026 9:51 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v8:
> > Changed the contant names to includer product vendor.
> > Moved the vendor specific code to vendor specific functions.
> >
> > Changes in v7:
> > Introduced vendor specific functions to retrieve the vsec data.
> >
> > Changes in v6:
> > Included "sizes.h" header and used the appropriate definitions instead
> > of constants.
> >
> > Changes in v5:
> > Added the definitions for Xilinx specific VSEC header id, revision,
> > and register offsets.
> > Corrected the error type when no physical offset found for device side
> > memory.
> > Corrected the order of variables.
> >
> > Changes in v4:
> > Configured 8 read and 8 write channels for Xilinx vendor Added checks
> > to validate vendor ID for vendor specific vsec id.
> > Added Xilinx specific vendor id for vsec specific to Xilinx Added the
> > LL and data region offsets, size as input params to function
> > dw_edma_set_chan_region_offset().
> > Moved the LL and data region offsets assignment to function for Xilinx
> > specific case.
> > Corrected comments.
> >
> > Changes in v3:
> > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > condition check.
> >
> > Changes in v2:
> > Reverted the devmem_phys_off type to u64.
> > Renamed the function appropriately to suit the functionality for
> > setting the LL & data region offsets.
> >
> > Changes in v1:
> > Removed the pci device id from pci_ids.h file.
> > Added the vendor id macro as per the suggested method.
> > Changed the type of the newly added devmem_phys_off variable.
> > Added to logic to assign offsets for LL and data region blocks in case
> > more number of channels are enabled than given in amd_mdb_data struct.
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 192
> > ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 178 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 3371e0a7..2efd149 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -14,14 +14,35 @@
> >  #include <linux/pci-epf.h>
> >  #include <linux/msi.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/sizes.h>
> >
> >  #include "dw-edma-core.h"
> >
> > -#define DW_PCIE_VSEC_DMA_ID                  0x6
> > -#define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > -#define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > -#define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> > -#define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> > +/* Synopsys */
> > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID         0x6
> > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR                GENMASK(10, 8)
> > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP                GENMASK(2, 0)
> > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH              GENMASK(9, 0)
> > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH              GENMASK(25, 16)
>
> Sorry, jump into at v8.
> According to my understand 'DW' means 'Synopsys'.
>

Yes, DW means Designware representing Synopsys here.
For the sake of clarity, a distinction was required to separate the names o=
f macros
having the similar purpose for other IP, Xilinx in this case. Otherwise, it=
 is causing confusion
which macros to use for which vendor. This also helps in future if any of t=
he vendors
try to retrieve a new or different VSEC IDs then all they need is to define=
 macros which
clearly show the association with the vendor, thus eliminating the confusio=
n.

> > +
> > +/* AMD MDB (Xilinx) specific defines */
> > +#define PCI_DEVICE_ID_XILINX_B054            0xb054
> > +
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR              GENMASK(10, 8)
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP              GENMASK(2, 0)
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9, 0)
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25, 16)
>
> These defination is the same. Need redefine again
>

It is the similar case as explained for the previous comment. Please check.

> > +
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> > +#define DW_PCIE_XILINX_MDB_INVALID_ADDR              (~0ULL)
>
> I think XILINX_PCIE_MDB_DEVMEM_OFF_REG_HIGH
>
> > +
> > +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP                0x200000
> > +#define DW_PCIE_XILINX_MDB_LL_SIZE           0x800
> > +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP                0x100000
> > +#define DW_PCIE_XILINX_MDB_DT_SIZE           0x800
> >
> >  #define DW_BLOCK(a, b, c) \
> >       { \
> > @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
> >       u8                              irqs;
> >       u16                             wr_ch_cnt;
> >       u16                             rd_ch_cnt;
> > +     u64                             devmem_phys_off;
> >  };
> >
> >  static const struct dw_edma_pcie_data snps_edda_data =3D { @@ -90,6
> > +112,64 @@ struct dw_edma_pcie_data {
> >       .rd_ch_cnt                      =3D 2,
> >  };
> >
> > +static const struct dw_edma_pcie_data xilinx_mdb_data =3D {
> > +     /* MDB registers location */
> > +     .rg.bar                         =3D BAR_0,
> > +     .rg.off                         =3D SZ_4K,        /*  4 Kbytes */
> > +     .rg.sz                          =3D SZ_8K,        /*  8 Kbytes */
> > +
> > +     /* Other */
> > +     .mf                             =3D EDMA_MF_HDMA_NATIVE,
> > +     .irqs                           =3D 1,
> > +     .wr_ch_cnt                      =3D 8,
> > +     .rd_ch_cnt                      =3D 8,
> > +};
> > +
> > +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> *pdata,
> > +                                        enum pci_barno bar, off_t star=
t_off,
> > +                                        off_t ll_off_gap, size_t ll_si=
ze,
> > +                                        off_t dt_off_gap, size_t
> > +dt_size) {
> > +     u16 wr_ch =3D pdata->wr_ch_cnt;
> > +     u16 rd_ch =3D pdata->rd_ch_cnt;
> > +     off_t off;
> > +     u16 i;
> > +
> > +     off =3D start_off;
> > +
> > +     /* Write channel LL region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->ll_wr[i].bar =3D bar;
> > +             pdata->ll_wr[i].off =3D off;
> > +             pdata->ll_wr[i].sz =3D ll_size;
> > +             off +=3D ll_off_gap;
> > +     }
> > +
> > +     /* Read channel LL region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->ll_rd[i].bar =3D bar;
> > +             pdata->ll_rd[i].off =3D off;
> > +             pdata->ll_rd[i].sz =3D ll_size;
> > +             off +=3D ll_off_gap;
> > +     }
> > +
> > +     /* Write channel data region */
> > +     for (i =3D 0; i < wr_ch; i++) {
> > +             pdata->dt_wr[i].bar =3D bar;
> > +             pdata->dt_wr[i].off =3D off;
> > +             pdata->dt_wr[i].sz =3D dt_size;
> > +             off +=3D dt_off_gap;
> > +     }
> > +
> > +     /* Read channel data region */
> > +     for (i =3D 0; i < rd_ch; i++) {
> > +             pdata->dt_rd[i].bar =3D bar;
> > +             pdata->dt_rd[i].off =3D off;
> > +             pdata->dt_rd[i].sz =3D dt_size;
> > +             off +=3D dt_off_gap;
> > +     }
> > +}
> > +
> >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > nr)  {
> >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -114,15 +194,15
> > @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t
> cpu_addr)
> >       .pci_address =3D dw_edma_pcie_address,  };
> >
> > -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > -                                        struct dw_edma_pcie_data *pdat=
a)
> > +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> > +                                            struct dw_edma_pcie_data
> > +*pdata)
> >  {
> >       u32 val, map;
> >       u16 vsec;
> >       u64 off;
> >
> >       vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > -                                     DW_PCIE_VSEC_DMA_ID);
> > +                                     DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
> >       if (!vsec)
> >               return;
> >
> > @@ -131,9 +211,9 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >           PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> >               return;
> >
> > -     pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability
> DMA\n");
> > +     pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended
> > + Capability DMA\n");
> >       pci_read_config_dword(pdev, vsec + 0x8, &val);
> > -     map =3D FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> > +     map =3D FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
> >       if (map !=3D EDMA_MF_EDMA_LEGACY &&
> >           map !=3D EDMA_MF_EDMA_UNROLL &&
> >           map !=3D EDMA_MF_HDMA_COMPAT && @@ -141,13 +221,13 @@
> static
> > void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >               return;
> >
> >       pdata->mf =3D map;
> > -     pdata->rg.bar =3D FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> > +     pdata->rg.bar =3D FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
> >
> >       pci_read_config_dword(pdev, vsec + 0xc, &val);
> >       pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > -                              FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
> > +
> > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
> >       pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > -                              FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> > +
> > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
>
> If you don't change macro name, these change is not necessary. If really =
need
> change macro name, make change macro name as sperated patch.
>

As explained above, the name change is required to avoid confusion.
The trigger to have the separate names for each IP is the inclusion of Xili=
nx IP that
is why no separate patch is created.

> >
> >       pci_read_config_dword(pdev, vsec + 0x14, &val);
> >       off =3D val;
> > @@ -157,6 +237,67 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> >       pdata->rg.off =3D off;
> >  }
> >
> > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > +                                          struct dw_edma_pcie_data
> > +*pdata) {
> > +     u32 val, map;
> > +     u16 vsec;
> > +     u64 off;
> > +
> > +     pdata->devmem_phys_off =3D DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +     if (PCI_VNDR_HEADER_REV(val) !=3D 0x00 ||
> > +         PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> > +             return;
> > +
> > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capa=
bility
> DMA\n");
> > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > +     map =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > +     if (map !=3D EDMA_MF_EDMA_LEGACY &&
> > +         map !=3D EDMA_MF_EDMA_UNROLL &&
> > +         map !=3D EDMA_MF_HDMA_COMPAT &&
> > +         map !=3D EDMA_MF_HDMA_NATIVE)
> > +             return;
> > +
> > +     pdata->mf =3D map;
> > +     pdata->rg.bar =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> val);
> > +
> > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > +     pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > +                              FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR=
_CH,
> val));
> > +     pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > +
> > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > +
> > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->rg.off =3D off;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HI=
GH,
> > +                           &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LO=
W,
> > +                           &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->devmem_phys_off =3D off;
> > +}
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >        * Tries to find if exists a PCIe Vendor-Specific Extended Capabi=
lity
> >        * for the DMA, if one exists, then reconfigures it.
> >        */
> > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > +
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
>
> dw_edma_pcie_get_xilinx_dma_data() should be here.
>
> Frank

Yes, this is good suggestion. Thanks!

> > +             /*
> > +              * There is no valid address found for the LL memory
> > +              * space on the device side.
> > +              */
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * Configure the channel LL and data blocks if number of
> > +              * channels enabled in VSEC capability are more than the
> > +              * channels configured in xilinx_mdb_data.
> > +              */
> > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > +                                            DW_PCIE_XILINX_MDB_LL_OFF_=
GAP,
> > +                                            DW_PCIE_XILINX_MDB_LL_SIZE=
,
> > +                                            DW_PCIE_XILINX_MDB_DT_OFF_=
GAP,
> > +                                            DW_PCIE_XILINX_MDB_DT_SIZE=
);
> > +     }
> >
> >       /* Mapping PCI BAR regions */
> >       mask =3D BIT(vsec_data->rg.bar);
> > @@ -367,6 +529,8 @@ static void dw_edma_pcie_remove(struct pci_dev
> > *pdev)
> >
> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > +       (kernel_ulong_t)&xilinx_mdb_data },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > --
> > 1.8.3.1
> >

