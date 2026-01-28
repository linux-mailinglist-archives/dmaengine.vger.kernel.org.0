Return-Path: <dmaengine+bounces-8552-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ORSEJoIemkK2AEAu9opvQ
	(envelope-from <dmaengine+bounces-8552-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 14:01:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95633A1BE0
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 14:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7389D300383E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADB34E760;
	Wed, 28 Jan 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="piT3Bbx5"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F7238D54;
	Wed, 28 Jan 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605189; cv=fail; b=LfOtCDNuIxFfl3AdnnH8h6BFk3/6c/Vta9v7cQG6ntcXbtScHsvI9sCI08+A4OU3nughSD3BSWdbCHxVomHA2cIKZQhcjjlbkC5L2Rp77oeSgYV6MJgxOgiXL4CS8Fy+AL/ilUelEP7SxADNyQjmyZfoxLhyXizGlLKzr0F3DJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605189; c=relaxed/simple;
	bh=YBiDzSjPt4iC9XrPXL1G1JfLPrVQS8ag2FSR14i9F+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pezbyjHn62bGmY5NsN1aBaXhGd6NlsWUnIpe54S9ecvbdbgkLtDaK6Ps2pMLKQUy7m31zmeF2fIT64H30BOjGEnCOL+qusowIqjuV0NxkNY1TpU5atgW4Vx5Zq3Bm3fIVBWGqSkjBkQCLCEBk0RBIwjD+TulatknHX/s+9WACvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=piT3Bbx5; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpyeT3W/wOQwfoEqTe/rki8BgnitHdNp5pZAsnPMHiPhSUMJ+TVkPGCoZL27BSEWCnr/TvALeuDOkpHlAYidUU1eNmBk0HIQzH1eh4wWKqfQtn+EMUJb4mRdck4ctTj+Rzmn5OXA/k2brkFeKT0VqHmUIzEX5DHqlyvIzXfo/hMCH0oYB05MMWab2m+GdEh0H2eeVuYgaJgJe7WJ/gHb/K515soGHMRgXeQJ5YuE1O5rmP1ICSdYFUn1x3/8cfchR5B7Mhhs+z21pZxXzih17iGb83dkamfVXD7YQLBfmdW0tdObo7qK81snSku6rHE8fOu9XEWFMchD0Y6zyEinPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUpKsIN/rSvZJ9xgis/RuG+PANr3kOS3VafKXFbDQKA=;
 b=jL77fn36rG2e6XUfzBNdqItCiHaHJiclkvG9Ez0ye+F2xkeCdW9JyH95Ipr/JwxN6VYanGDUfdr06LV5ok4e+Ne2qdBknS7z7XfyZXdKHjaCcstArRCmHjcyjTlCl1NJgwrgGQuqfonNm2/qEIi0/efStaR9hAmoN4FUd8r4b32AZHSywdY+AWd8fF+Vgo4qKZ/QS2Sq0YZEvMRBeAM10Y/9VcCoAJ7rRWam7QRm/KdzjsHmsfPrDskJla8ehGHLDWRSWYD64Kc3o1e5LUP8Qgt7fIv1g7K2nxHpQXRdZjpSHzktEbGm0IogLSOlyOfNDmmNSBUKPetxjhM9RWpUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUpKsIN/rSvZJ9xgis/RuG+PANr3kOS3VafKXFbDQKA=;
 b=piT3Bbx55YE/gr4p6SNmmIxauqtjdZ/lA8dXSolOxda0HNiSc51WkxQ3K40vRHkG2R3hJ9j2UDGNQrplDllLQ1Mq3aQRfrKahjBUdt/P2kee4Erv+fdLjp0sEz8U+iDLcY8ZwQeui1IWw/IUWxOSNCHkGIRYYs7cVML96S7bmBw=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 12:59:44 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 12:59:43 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMAgAILjACAAQilwIAG704AgAJHbSA=
Date: Wed, 28 Jan 2026 12:59:43 +0000
Message-ID:
 <SA1PR12MB8120877E05B98E26B022C3669591A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
In-Reply-To: <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T05:48:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB6116:EE_
x-ms-office365-filtering-correlation-id: a1c84612-0aab-4997-e7e6-08de5e6d1b48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JaYGvWO9wtlYLa1dqudM39estISdDm733FEjEuFlD5hDs/Axc2Cc+Qg22X64?=
 =?us-ascii?Q?cSAGovRjSArQ+/1Y2BeYjz5dNhNA0j+fxYGVzEo90bYm8pvu/Dv4gSeyu+x2?=
 =?us-ascii?Q?HxQKTVLYGEUWt0qsxHrLQERrg6wFOLbj+uA0WaPA+NJkHYDImuia2LjMIIus?=
 =?us-ascii?Q?Z5LbhhJr+w4274RssgnysLOmsZaFI1aBnMz9AruTtRExLe3aZT9iDmoxsCKF?=
 =?us-ascii?Q?pEXrNZuI+H1zD16gUM/x5nptU2gBAkVtQZgScnxGhobgmqytFOI++5uWDvtc?=
 =?us-ascii?Q?LTFpNsiqST2aSuBjzeVahfEBbaR1rCf/jcMtbjQlQAeuJvof6rFvM0BOxv9E?=
 =?us-ascii?Q?VCHj6+uhy0w6PfbOaOZVB2csryFjgC9SI6LEwgarWKxk5ztiYegyd2DQc5Ob?=
 =?us-ascii?Q?ls1Rfm/CuAPrXYN+fdknvNSvxwwPzkr+YOL4pj49yQ9Pa8AdCrX+JFYr2FWY?=
 =?us-ascii?Q?y/j3USVx1yAZyjTGBKNNUS+bKDhXBfbPplPsHPhwCDs9amn62HPnOI9qYQDW?=
 =?us-ascii?Q?X9eNZWSeuQ2xiIAYdoOUU55MxP8+oLsSjQbn48GurDBuxC8HFEZB6rSPYexA?=
 =?us-ascii?Q?ALK4p8A90Equ8sp2pd9pAZAGc2TBhoHBrCLKBgxfND5E21MZMmwJPdpwrcuh?=
 =?us-ascii?Q?jbEEDZllDLqlwKUuy/MjybhWWb15Ag5jVv/JjIuROAlCFQTFhD+uZiacjX4r?=
 =?us-ascii?Q?7iFtyxWV7jIIaw5/kAQw2zBp6XnYBQaY2hx4ey0kY2onlNLOwPlDLOEVlN/i?=
 =?us-ascii?Q?cLmExndD3K1oETuwHxvo4vqc17a0dALJcKESlALGKxA9P4GBNX5FO1E3DRa8?=
 =?us-ascii?Q?DYcitv1xlhJimvFPQ1vQA6MORJp/0KXql/4cLdpRf7FFmL8MikbvXmxeVCps?=
 =?us-ascii?Q?yDMTBuNcxuEgRGRSwzKWLLWtAh3Sz2kdLq7pVITSg2whNgkPNbsuo7JaeB5B?=
 =?us-ascii?Q?kEjoxR1bRNV52wy9qBWnXJ/c0NTPtw6xuJ+TrQIVWwdN0JA6Ea90eDo6eO8w?=
 =?us-ascii?Q?eHh+CxqePvjGTCDD1sB3vBIafwcFBZmjTiPSw0s7hgmpuBwdOpOigWLVIt7B?=
 =?us-ascii?Q?atLj45BqiXf5d3TP0Zijty+EfFCj8j7vvOi2iPHytavXogJzi03Dx9y/lUhq?=
 =?us-ascii?Q?l4Mcn1wK9GfboJ0ITVfykg2igjOWZDyvjRRpe0BtbXLJiS4Tp76ZixFV3WME?=
 =?us-ascii?Q?gI8ogrd2DUvsl2WCwZgUHECKva5TdkOgVkA02JgCoH+f8pko31RiRtrZdm+W?=
 =?us-ascii?Q?g7licThslO8g25+54o5vRdMBBo5yobBntzpmzanh0qRDC4TiE4kgr0NCMgOe?=
 =?us-ascii?Q?EuFuIJme4otzM/r+ipQqtzWP5tyC+gfaKzqB7mtnjK6bkaAIadsiBRPxUdqF?=
 =?us-ascii?Q?Ra++G/Pq4Rn9wy+9JXMEgGpA0ThY5QjtJz3Ymao9tW93k4CuNCpTgvwT8QUb?=
 =?us-ascii?Q?Bl2pnz8J+jZ14RvAl8WVddmvkuQY4Og2cT6D4jKvIEqP1ubz1lIpLwq5gkVi?=
 =?us-ascii?Q?LVBHYe9gNUlqF5UwgSi9a0JGNXjnkiMSdjt70fl/tLcRcOdw/or4it/59hJ6?=
 =?us-ascii?Q?4RJL9KMLV2gFJBS3D+T9mXfPLHgzgFq/d/7yhR/e2ueBgFN9rJOhlz1o9Xjn?=
 =?us-ascii?Q?c28qqeNQ28XeBo1JYiWAQI4bv/kPRa+qF2OWvHb6CVgm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D10I8dNaIBB65F9BdHDVkx0AMHB7j2lbBZd+z7cb0uQEx2jghVfdw3JM6pDa?=
 =?us-ascii?Q?a1Fd0l7pT0btwVJhNi3e4POMVNDtyskoTsuCFrcnb4WbJxb+a+Bozhz7Q9sN?=
 =?us-ascii?Q?kxxMdJCcI3LK5CGy1wlVAV8EO76JoR7sBJEzUitHIjLkXryic1nT7/k66h6r?=
 =?us-ascii?Q?cG5fX5bsnoLY+tGtpXT24UjdPmSAqey1Lv1Bj3qpj35SEMekwgAlEUacERQ+?=
 =?us-ascii?Q?UiPBa1Ik+gYfuORNbzl1I9sCjWEECxwjw81QvlpAatuhMtb1dEq+XZGKoTsn?=
 =?us-ascii?Q?bHxdmBikm6faQ9UNKQkhDaaz+EOWe/bUmVY+fXCJ38Hpi4PQuowuOdHTBubN?=
 =?us-ascii?Q?F3uX/jLqx0S6TQ2E3KJp32lY72ri4xfCcfNcxOjxsUY7Q1xKWNS5mMER/LvO?=
 =?us-ascii?Q?r/ua794l9zceEoWTZgEpnTGW8SpXCUTDJBCcVk6Q7E44r1jZ++Dc7ejnE0q+?=
 =?us-ascii?Q?iUvHoe01iU1t2GEx6ptLINLxtLSCBjOiJ3YI/L7sjgG8zSlleBnVpljBJD9M?=
 =?us-ascii?Q?w7W38UDdSC94AQDJnI5eOr/hlKh/bSRu8NTEsnn2ygdr03/CuEcoh104IMmZ?=
 =?us-ascii?Q?0h8DvhS9oErY0cOXkuXNPcN2wpiq9SYqWCeTdfecLYDZ1iJl3sj2iTY++0Sq?=
 =?us-ascii?Q?Ov89looNfC9MpQBYX7zdlaMvEObB6FP2vwFBv7pFt3C5wOSeZTvgDt8U8hkJ?=
 =?us-ascii?Q?TN3l5EXIfTE0+v2NIAJMKciA76gyW4+uTIikHqNFQAGPuv6fk0UPxYq15l4C?=
 =?us-ascii?Q?nxUiX8mNLC2JF4lZJHLbrJznsgUDfqX5gKOu4RFdWzpGLBkkzuWUK7qm/3/C?=
 =?us-ascii?Q?qcHzFhX5Uqt/xJCJggS7wbd3e8KqsEVS68qUJR07R2e6SkW+4nUroytAOkuM?=
 =?us-ascii?Q?xSkSdoCymiqrT2A/2yZFkKiQLMMRc6QZpIuXAsZDv/OtECDFHzQMVm+b1wi9?=
 =?us-ascii?Q?bFVrYTYFF15kA6mi1R5S7yNEqVczTg8HuzFKie8evsV3p2808djv9HKECQLX?=
 =?us-ascii?Q?Fdy9E4RUD+IPfUlXXq+80+EgsN3psFMmW17RCKDIEn4AztgtbSj80VHre7fi?=
 =?us-ascii?Q?DOggSAjSZ2b44ry8zt8eRQWvh2wGJq3sBV6ElntzqIhJxmIRqgvqL0+5d01a?=
 =?us-ascii?Q?wbpumJ+GJmD8/MM94NjA4eIDqrS9Auh2juXpKykEQsZhPzy9xTzo+knTyMsr?=
 =?us-ascii?Q?xYu1jLqRvaJHfZnxVIONCRp0Af3Flv9K21t++ym+nT7DetKHWWnwg75pTv6y?=
 =?us-ascii?Q?UOmTmtSQQNeix6+llpX9UBOkcw7iiAa3diNGkAfSR9nMmSRsHxQ/f7IDE5E/?=
 =?us-ascii?Q?9Q6lbRwIaotUyBbYnvS+HoX9EAEpbY+A7GH8HLthoAigIkUks9nBlmVxl/x4?=
 =?us-ascii?Q?9OhjdOzatOrNa8T0k5RrS7Hqar4RVK+AAdutth92vGLH7CLsCHlOP9qHaF7A?=
 =?us-ascii?Q?KluqUns4qE1pYP5pgFsN3XVgM8J73VYxD1L1fr9fRPZ30vSpVXxYhtxqzMF8?=
 =?us-ascii?Q?JySKJ7x6BqHzvYY56P0oSskdFyXP9oqrBu3S8YG4/iiVbN6Mnig3Pw3PAttw?=
 =?us-ascii?Q?JFR9DSVe4wUvWgMcD9DkFKwz69VFzuRBnEhNTZ8iDOQE9lC+3dLjo2voA7nj?=
 =?us-ascii?Q?7gSYSh/FEoAg/VYkZ3jKBTVM3UPl4lowWgO1Dum7Ft0Tv3rNUjYktKkXoHjD?=
 =?us-ascii?Q?k87H+P1rifPEHtfizxi0azx4ZYb+K08Bb8/Y02tSqfPqkEy2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c84612-0aab-4997-e7e6-08de5e6d1b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 12:59:43.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMoauDPzSsPRB64nJjXFSajYo3SQ6xhXa99BCqaFfkSFMYYFQhUHICbLas7GbEIQfvOXZvcEnX0wlOFad19ZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8552-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[devendra.verma.amd.com:query timed out,michal.simek.amd.com:query timed out,mani.kernel.org:query timed out,vkoul.kernel.org:query timed out,kernel.vger.kernel.org:query timed out,linux-pci.vger.kernel.org:query timed out,frank.li.nxp.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 95633A1BE0
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Tuesday, January 27, 2026 12:30 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode

--[ Snipped some headers to reduce the size of this mail ]--

> > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL
> mode.
> > > > > > > > The current code does not have the mechanisms to enable
> > > > > > > > the DMA transactions using the non-LL mode. The following
> > > > > > > > two cases are added with this patch:
> > > > > > > > - For the AMD (Xilinx) only, when a valid physical base add=
ress of
> > > > > > > >   the device side DDR is not configured, then the IP can st=
ill be
> > > > > > > >   used in non-LL mode. For all the channels DMA
> > > > > > > > transactions will
> > > > > > >
> > > > > > > If DDR have not configured, where DATA send to in device
> > > > > > > side by non-LL mode.
> > > > > > >
> > > > > >
> > > > > > The DDR base address in the VSEC capability is used for
> > > > > > driving the DMA transfers when used in the LL mode. The DDR is
> > > > > > configured and present all the time but the DMA PCIe driver
> > > > > > uses this DDR base address (physical address) to configure the =
LLP
> address.
> > > > > >
> > > > > > In the scenario, where this DDR base address in VSEC
> > > > > > capability is not configured then the current controller
> > > > > > cannot be used as the default mode supported is LL mode only.
> > > > > > In order to make the controller usable non-LL mode is being
> > > > > > added which just needs SAR, DAR, XFERLEN and control register
> > > > > > to initiate the transfer. So, the DDR is always present, but
> > > > > > the DMA PCIe driver need to know the DDR base physical address
> > > > > > to make the transfer. This is useful in scenarios where the
> > > > > > memory
> > > > > allocated for LL can be used for DMA transactions as well.
> > > > >
> > > > > Do you means use DMA transfer LL's context?
> > > > >
> > > >
> > > > Yes, the device side memory reserved for the link list to store
> > > > the descriptors, accessed by the host via BAR_2 in this driver code=
.
> > > >
> > > > > >
> > > > > > > >   be using the non-LL mode only. This, the default non-LL m=
ode,
> > > > > > > >   is not applicable for Synopsys IP with the current code a=
ddition.
> > > > > > > >
> > > > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and
> Synosys,
> > > > > > > >   and if user wants to use non-LL mode then user can do so =
via
> > > > > > > >   configuring the peripheral_config param of dma_slave_conf=
ig.
> > > > > > > >
> > > > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > > > ---
> > > > > > > > Changes in v8
> > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > >
> > > > > > > > Changes in v7
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v6
> > > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > > >   Removed the comment related to doorbell.
> > > > > > > >
> > > > > > > > Changes in v5
> > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > > dev_err().
> > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > >
> > > > > > > > Changes in v4
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v3
> > > > > > > >   No change
> > > > > > > >
> > > > > > > > Changes in v2
> > > > > > > >   Reverted the function return type to u64 for
> > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > >
> > > > > > > > Changes in v1
> > > > > > > >   Changed the function return type for
> dw_edma_get_phys_addr().
> > > > > > > >   Corrected the typo raised in review.
> > > > > > > > ---
> > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > > +++++++++++++++++++++---
> > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > > ++++++++++++++++++--
> > > > > ------
> > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > > >
> > > > > > > edma-v0-core.c have not update, if don't support, at least
> > > > > > > need return failure at dw_edma_device_config() when backend i=
s
> eDMA.
> > > > > > >
> > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > index b43255f..d37112b 100644
> > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > @@ -223,8 +223,32 @@ static int
> > > > > > > > dw_edma_device_config(struct
> > > > > > > dma_chan *dchan,
> > > > > > > >                                struct dma_slave_config *con=
fig)  {
> > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > +     int non_ll =3D 0;
> > > > > > > > +
> > > > > > > > +     if (config->peripheral_config &&
> > > > > > > > +         config->peripheral_size !=3D sizeof(int)) {
> > > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > > +                     "config param peripheral size mismatc=
h\n");
> > > > > > > > +             return -EINVAL;
> > > > > > > > +     }
> > > > > > > >
> > > > > > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * When there is no valid LLP base address available
> > > > > > > > + then the
> > > default
> > > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > > +      *
> > > > > > > > +      * Cases where LL mode is enabled and client wants
> > > > > > > > + to use the
> > > non-LL
> > > > > > > > +      * mode then also client can do so via providing the
> > > peripheral_config
> > > > > > > > +      * param.
> > > > > > > > +      */
> > > > > > > > +     if (config->peripheral_config)
> > > > > > > > +             non_ll =3D *(int *)config->peripheral_config;
> > > > > > > > +
> > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > +     if (chan->dw->chip->non_ll ||
> > > > > > > > + (!chan->dw->chip->non_ll &&
> > > non_ll))
> > > > > > > > +             chan->non_ll =3D true;
> > > > > > > > +
> > > > > > > >       chan->configured =3D true;
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > dma_chan *dchan)
> > > > > > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer=
-
> > > >dchan);
> > > > > > > >       enum dma_transfer_direction dir =3D xfer->direction;
> > > > > > > >       struct scatterlist *sg =3D NULL;
> > > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > > > > > >       struct dw_edma_burst *burst;
> > > > > > > >       struct dw_edma_desc *desc;
> > > > > > > >       u64 src_addr, dst_addr; @@ -419,9 +443,11 @@ static
> > > > > > > > void dw_edma_device_issue_pending(struct
> > > > > > > dma_chan *dchan)
> > > > > > > >       if (unlikely(!desc))
> > > > > > > >               goto err_alloc;
> > > > > > > >
> > > > > > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > -     if (unlikely(!chunk))
> > > > > > > > -             goto err_alloc;
> > > > > > > > +     if (!chan->non_ll) {
> > > > > > > > +             chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > +             if (unlikely(!chunk))
> > > > > > > > +                     goto err_alloc;
> > > > > > > > +     }
> > > > > > >
> > > > > > > non_ll is the same as ll_max =3D 1. (or 2, there are link bac=
k entry).
> > > > > > >
> > > > > > > If you set ll_max =3D 1, needn't change this code.
> > > > > > >
> > > > > >
> > > > > > The ll_max is defined for the session till the driver is
> > > > > > loaded in the
> > > kernel.
> > > > > > This code also enables the non-LL mode dynamically upon input
> > > > > > from the DMA client. In this scenario, touching ll_max would
> > > > > > not be a good idea as the ll_max controls the LL entries for
> > > > > > all the DMA channels not just for a single DMA transaction.
> > > > >
> > > > > You can use new variable, such as ll_avail.
> > > > >
> > > >
> > > > In order to separate out the execution paths a new meaningful
> > > > variable
> > > "non_ll"
> > > > is used. The variable "non_ll" alone is sufficient. Using another
> > > > variable along side "non_ll" for the similar purpose may not have
> > > > any
> > > added advantage.
> > >
> > > ll_avail can help debug/fine tune how much impact preformance by
> > > adjust ll length. And it make code logic clean and consistent. also
> > > ll_avail can help test corner case when ll item small. Normall case i=
t is
> hard to reach ll_max.
> > >
> >
> > Thank you for your suggestion. The ll_max is max limit on the
> > descriptors that can be accommodated on the device side DDR. The ll_ava=
il
> will always be less than ll_max.
> > The optimization being referred can be tried without even having to
> > declare the ll_avail cause the number of descriptors given can be
> > controlled by the DMA client based on the length argument to the
> dmaengine_prep_* APIs.
>
> I optimzied it to allow dynatmic appended dma descriptors.
>
> https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-
> 9a98c9c98536@nxp.com/T/#t
>
> > So, the use of dynamic ll_avail is not necessarily required. Without
> > increasing the ll_max, ll_avail cannot be increased. In order to
> > increase ll_max one may need to alter size and recompile this driver.
> >
> > However, the requirement of ll_avail does not help for the supporting t=
he
> non-LL mode.
> > For non-LL mode to use:
> > 1) Either LL mode shall be not available, as it can happen for the Xili=
nx IP.
> > 2) User provides the preference for non-LL mode.
> > For both above, the function calls are different which can be
> > differentiated by using the "non_ll" flag. So, even if I try to
> > accommodate ll_avail, the call for LL or non-LL would be ambiguous as i=
n
> case of LL mode also we can have a single descriptor as similar to non-LL
> mode.
> > Please check the function dw_hdma_v0_core_start() in this review where
> > the decision is taken Based on non_ll flag.
>
> We can treat ll_avail =3D=3D 1 as no_ll mode because needn't set extra LL=
 in
> memory at all.
>

I analyzed the use of ll_avail but I think the use of this variable does no=
t fit at
this location in the code for the following reasons:
1. The use of a new variable breaks the continuity for non-LL mode. The var=
iable
    name non_ll is being used for driving the non-LL mode not only in this =
file but also
   in the files relevant to HDMA. This flag gives the clear indication of L=
L vs non-LL mode.
   In the function dw_hdma_v0_core_start(), non_ll decided the mode to choo=
se.
2. The use of "ll_avail" is ambiguous for both the modes. First, it is asso=
ciated with LL mode only.
     It will be used for optimizing / testing the Controller performance ba=
sed on the
    number of descriptors available on the Device DDR side which is for LL =
mode. So when
    it is being used for LL mode then it is obvious that it excludes any us=
e for non-LL mode.
    In the API dw_edma_device_transfer(), the ll_avail will be used for cre=
ating the bursts.
    If ll_avail =3D 1 in the above API, then it is ambiguous whether it is =
creating the burst for
     LL or non-LL mode. In the above API, the non_ll is sufficient to have =
the LL mode
     and non-LL burst allocation related piece of code.

I think ll_avail, if used for trying out to optimize / debug the settings r=
elated to number of
descriptors for LL mode then it should be part of the separate discussion /=
 update not related to
non-LL.

> >
> > > >
> > > > > >
> > > > > > > >
> > > ...
> > > > > > > > +
> > > > > > > > + ll_block->bar);
> > > > > > >
> > > > > > > This change need do prepare patch, which only change
> > > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > > >
> > > > > >
> > > > > > This is not clear.
> > > > >
> > > > > why not. only trivial add helper patch, which help reviewer
> > > > >
> > > >
> > > > I was not clear on the question you asked.
> > > > It does not look justified when a patch is raised alone just to
> > > > replace this
> > > function.
> > > > The function change is required cause the same code *can* support
> > > > different IPs from different vendors. And, with this single change
> > > > alone in the code the support for another IP is added. That's why
> > > > it is easier to get the reason for the change in the function name =
and
> syntax.
> > >
> > > Add replace pci_bus_address() with dw_edma_get_phys_addr() to make
> > > review easily and get ack for such replacement patches.
> > >
> > > two patches
> > > patch1, just replace exist pci_bus_address() with
> > > dw_edma_get_phys_addr() patch2, add new logic in
> dw_edma_get_phys_addr() to support new vendor.
> > >
> >
> > I understand your concern about making the review easier. However,
> > given that we've been iterating on this patch series since September
> > and are now at v9, I believe the current approach is justified. The
> > function renames from
> > pci_bus_address() to dw_edma_get_phys_addr() is directly tied to the
> > non-LL mode functionality being added - it's needed because the same
> > code now supports different IPs from different vendors.
> >
> > Splitting this into a separate preparatory patch at this stage would
> > further delay the review process. The change is kind of
> > straightforward and the context is clear within the current patch. I re=
quest
> you to review this patch to avoid additional review cycles.
> >
> > This also increases the work related to testing and maintaining multipl=
e
> patches.
> > I have commitment for delivery of this, and I can see adding one more
> > series definitely add 3-4 months of review cycle from here. Please
> > excuse me but this code has already
>
> Thank you for your persevere.
>

Thank you for your support.

> > been reviewed extensively by other reviewers and almost by you as
> > well. You can check the detailed discussion wrt this function at the fo=
llowing
> link:
> >
> https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@
> SA1
> > PR12MB8120.namprd12.prod.outlook.com/
> >
>
> But still not got reviewed by tags. The recently,  Manivannan Sadhasivam =
,
> Niklas Cassel and me active worked on this driver. You'd better to get th=
eir
> feedback. Bjorn as pci maintainer to provide generally feedback.
>

Hi Manivannan Sadhasivam, Vinod Koul and Bjorn Helgaas
Could you please provide your feedback on the patch?
You have reviewed these patches extensively on the previous versions of the=
 same series.

Regards,
Devendra

>
> > > >
> > > > > >
> > > > > > > >               ll_region->paddr +=3D ll_block->off;
> > > > > > > >               ll_region->sz =3D ll_block->sz;
> > > > > > > >
> > > ...
> > > > > > > >
> > > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct
> > > > > > > > +dw_edma_chunk
> > > > > > > *chunk)
> > > > > > > > +{
> > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > +     struct dw_edma *dw =3D chan->dw;
> > > > > > > > +     struct dw_edma_burst *child;
> > > > > > > > +     u32 val;
> > > > > > > > +
> > > > > > > > +     list_for_each_entry(child, &chunk->burst->list,
> > > > > > > > + list) {
> > > > > > >
> > > > > > > why need iterated list, it doesn't support ll. Need wait for
> > > > > > > irq to start next
> > > > > one.
> > > > > > >
> > > > > > > Frank
> > > > > >
> > > > > > Yes, this is true. The format is kept similar to LL mode.
> > > > >
> > > > > Just fill one. list_for_each_entry() cause confuse.
> > > > >
> > > > > Frank
> > > >
> > > > I see, we can use list_first_entry_or_null() which is dependent on
> > > > giving the type of pointer, compared to this list_for_each_entry()
> > > > looks neat and agnostic to the pointer type being used. Though, it
> > > > can be
> > > explored further.
> > > > Also, when the chunk is allocated, the comment clearly spells out
> > > > how the allocation would be for the non LL mode so it is evident
> > > > that each chunk would have single entry and with that
> > > > understanding it is clear that loop will also be used in a similar
> > > > manner, to retrieve a single entry. It is a similar use case as of
> > > > "do {}while (0)" albeit needs a context to
> > > understand it.
> > >
> > > I don't think so. list_for_each_entry() is miss leading to reader
> > > think it is not only to one item in burst list, and use polling
> > > method to to finish many burst transfer.
> > >
> > > list_for_each_entry() {
> > >         ...
> > >         readl_timeout()
> > > }
> > >
> > > Generally, EDMA is very quick, polling is much quicker than irq if da=
ta is
> small.
> > >
> > > Frank
> > >
> >
> > The polling is not required. The single burst will raise the interrupt
> > and from the interrupt context another chunk will be scheduled. This
> > cycle repeats till all the chunks with single burst are exhausted.
> >
> > The following comment made in function dw_edma_device_transfer() in
> > the same patch makes it amply clear that only a single burst would be
> handled for the non-LL mode.
> > +       /*
> > +        * For non-LL mode, only a single burst can be handled
> > +        * in a single chunk unlike LL mode where multiple bursts
> > +        * can be configured in a single chunk.
> > +        */
> >
> > Looking at the way bursts are appended to chunks and chunks in
> > dw_edma_device_transfer() are scheduled for non-LL mode then it is clea=
r
> what non-LL mode would handle in terms of bursts.
> > I just kept the format to match it with the LL mode format otherwise
> > there is no need of this comment and we can follow the syntax for a sin=
gle
> entry alone.
> > Please share your suggestion if these descriptions fail to provide the =
clear
> context and intent.
>
> Avoid use list_for_each_entry() here to prevent miss-leading.
>
> Frank
>

Sure, thanks, I will push this change in next version.

> >
> > > >
> > > > > >
> > > > > > >
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > > > > > > + HDMA_V0_CH_EN);
> > > > > > > > +
> > > > > > > > +             /* Source address */
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > > > > > +                       lower_32_bits(child->sar));
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > > > > > +                       upper_32_bits(child->sar));
> > > > > > > > +
> > > > > > > > +             /* Destination address */
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > > > > > +                       lower_32_bits(child->dar));
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > > > > > +                       upper_32_bits(child->dar));
> > > > > > > > +
> > > > > > > > +             /* Transfer size */
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > + transfer_size,
> > > > > > > > + child->sz);
> > > > > > > > +
> > > > > > > > +             /* Interrupt setup */
> > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, in=
t_setup) |
> > > > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > > > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > > +
> > > > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) =
{
> > > > > > > > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > > > > > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > > > > > +             }
> > > > > > > > +
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > + int_setup, val);
> > > > > > > > +
> > > > > > > > +             /* Channel control setup */
> > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, co=
ntrol1);
> > > > > > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, control1,
> > > > > > > > + val);
> > > > > > > > +
> > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > > +     }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk
> > > > > > > > +*chunk, bool
> > > > > > > > +first) {
> > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > +
> > > > > > > > +     if (chan->non_ll)
> > > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > > > +     else
> > > > > > > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > > > > > > +
> > > > > > > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan
> > > > > > > > *chan)
> > > > > {
> > > > > > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > @@ -12,6 +12,7 @@
> > > > > > > >  #include <linux/dmaengine.h>
> > > > > > > >
> > > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > > +#define HDMA_V0_CH_EN                                BIT(0=
)
> > > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b 100644
> > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > >
> > > > > > > >       struct dw_edma          *dw;
> > > > > > > > +     bool                    non_ll;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  /* Export to the platform drivers */
> > > > > > > > --
> > > > > > > > 1.8.3.1
> > > > > > > >

