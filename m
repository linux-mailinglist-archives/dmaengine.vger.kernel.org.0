Return-Path: <dmaengine+bounces-7616-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CB2CBDA91
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF9B30B4C40
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598C32F74A;
	Mon, 15 Dec 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4DkkKgpr"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1C32E74A;
	Mon, 15 Dec 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798795; cv=fail; b=RuY1S2WmQwzwcCyvyc0uc+TcZ5R4+QAAVV01sI7fwE5gw2CAyvTc+MLwm/ClVcRJHLUKitAFx2L/k0hqo5KE79mc//uHGBaGHODPKSvXAHrRvQ2EFjRqW42mYyFbuLbrnXKrjPIpTPvhKIp+RFfhFxt+u/58xj/d8iwYVLLaMXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798795; c=relaxed/simple;
	bh=W/fCVwyu5jGbulnz+ZKqa8fJUjcPFSwS+OuNjBNgkVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5Rge57wILxhwwjWkUsyLw67ioKZ1hJE3ksgTTyp2jXgZYr7DgxVCiKFg1Y6q4MuKdzPdzB0eEQi0H4K4F1nJhptq0BHSi9zNAg8TIqYjHUspm/i8nNBzFQOZ7NyosB2pEH60Q+4e3Ebl/yN3HWDTLkgrxt24fKf7Eg2hgOXJz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4DkkKgpr; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSEuREEYYTaO2J+VbeoLv4hPfbyK4VqSj+sKDqZ7M5rJ1r7j4jkJUPHo2ibnk1cJgWO4XCv/dN81SiAyoTAKsuI0669sR1YFzqr36LUp7iPgIaBJQQ4Nos8zLan23sdl86LMlhEcXvgQdK0oarfChE9WPh1kq+TMWrbz4EifbtHJaYn5kBpfC4NUtaXncLAMvfKc3h3xWdGmIfPLO+yIa8hzLS54ysckYDZdf89m0ja+tql0/j5RELyQQmDlI2a3dkXp2/nlrZpV/iGY7XOhLqBRtPlfo4JV9ANvR3pB+X/J9NzJJg2QSd5QyD+dStIP4HRgMwnwE1q9rH5hRhkIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOeKFysV3QWuCAKFg6nWkaW7rqpPg5nKYXyWJ+HYs8c=;
 b=j+W3SD6U7XIVh2LreCC1gMnCu5MwwJrhms9TZTI0u7fLT21jAjHOMqAesnezvHurUbxPIx/rkKkv/2rxBv5Eo71WRrxgbc4BF7DZ56Ugv64ml2a5mD3ipIkFuazAtpfFXRtvx4//t8WcdiX7HahCtfc9mg8UEuOlX/+OdY4x9FE4KY39/iUvMsX0SFVnrMFSREsvkozcUIhnJWS+xqji3fK6DIdYwAX6H57FvgCHPq8c2norLLbOmtYKUL+dGQTPbr2tv4YFMtFgtwHs9Q/S3nbIU+t8Whpm02onShbF+vjcT+OhaoXPcDKRBWR+A954frwpYWRjaJ69sMOtdbKGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOeKFysV3QWuCAKFg6nWkaW7rqpPg5nKYXyWJ+HYs8c=;
 b=4DkkKgprKVs7Lhu3dBn8b+Pj2DJuAXsj7LOZrStKcFKlyuUtQRuCLtflR2AHNzEWYFWnLLvQwYogPvUyNL6PsYvZ9pYzpQg6gfvbot+rfgd1cwk6dlEVQusq6UxN/RoBz2BABwSXk+YT7Bf1roODN7lnu3B7GI3zlNcN161mVZI=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 11:39:49 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:39:48 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v7 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v7 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHca2HPx6tzXE0g6ESpnNbmzzMaXLUeTcYAgARDlyA=
Date: Mon, 15 Dec 2025 11:39:48 +0000
Message-ID:
 <SA1PR12MB81204C807C2F7C72730EC82295ADA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251212122056.8153-2-devendra.verma@amd.com>
 <20251212180808.GA3645554@bhelgaas>
In-Reply-To: <20251212180808.GA3645554@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-15T11:15:05.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|LV3PR12MB9330:EE_
x-ms-office365-filtering-correlation-id: ec56bcd6-60f1-4200-c931-08de3bcea6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?10el4Sv047NQKdZ9DdR2auIy9r+x1m74D6/crpMCIpza5+Sci6GqqsPYX2t/?=
 =?us-ascii?Q?vESqF6oQjlVy7GM4qv9mQ4M3dOJmw5Ugt5JIPkA7/p5zuhPFXaIDkEXSOxsB?=
 =?us-ascii?Q?ubSuy3gpFgin4t6NzwsK480noCwI3kwQFdqwe5sm4vlBb+7XSn71dfKEXk7n?=
 =?us-ascii?Q?rIEwQQw+SzDmwh9N6wxyopNPXtnJUHanh3CI4h5f89tlVHzVHHQT/mE7PQ/4?=
 =?us-ascii?Q?e2dcyq0XB+mQ+b6L0vS3r7hqjcqb/l/7rUmOjWjXvUtvn3HVcwVynk/cuE8X?=
 =?us-ascii?Q?cfj8KbmZCrRSdBP3eym7zjex7bnapb0C4dhYOVqvabxkhRxK5uEQp1+iHwHc?=
 =?us-ascii?Q?oMsRjJqkX7TJ6VuLwWVubhUl8zl8duCa81bUqiUyQ6fZH5Oij6oWSSul5JPj?=
 =?us-ascii?Q?ks4Auc6lQDO1dFxSWCr2/K+Soz59VPUsztDCZKMTkgdNyP6bw/Scfb0W6tYa?=
 =?us-ascii?Q?XEJBBfPTjAndUK5bEQmQ4KIS4BTu5IOgA4QXn2E5MCBfnMA0pB9hwyrV+3zf?=
 =?us-ascii?Q?e9PWm8LTuQaEQXyTwL4K8y6aJFLUtwoiNKkTP1FErvNkqskDS69duQKU78s2?=
 =?us-ascii?Q?7cV0BrwSx+OmjPovm+IaqXhsDY8F8sw4L7/ijil9RDgsVSe0yBC6iOu+T+39?=
 =?us-ascii?Q?COf1sg/opdcUleK5U5M+IWaHenpx131WnWeI5Eh6qb5XCz21oa6e+qg5NntH?=
 =?us-ascii?Q?8GbHIaTPkbj360SJKar17WOMcfH9//hvozpN8eo6XXrxm8dIcgo+S5ZvNCYe?=
 =?us-ascii?Q?JmqYj59tDVNl0qnCuCEQORagaGo642wGD8aWVK+lHoJ+xitmIaC8RNnhPUwV?=
 =?us-ascii?Q?YvpBggXhmyPdbcOBQYwi8crbkb0JTGkFFliU8trTbQpWy4ziv4aqIbPRWsXe?=
 =?us-ascii?Q?jSKIHlH9DA/F+w5uchRWs62z0HGLuxK03lkm7eB8XxHFBnMs2nANaZbvdrip?=
 =?us-ascii?Q?jsgnoId2EYYLqr50A3aEjt6RtmX8XzqwlSUUmeuUzYDwpcmWcfxMcVbg7Fqe?=
 =?us-ascii?Q?32bIN6tNSqsGURpmObyJqeHV94D4V/dDUHOSTq9e2W02c3j+6ETrn3RkXmg/?=
 =?us-ascii?Q?TZd2/n56Beb0I/1tfnBqL7B1jsnyBUWvPPtZbTixpe2HuxAsugGdhfGhwKOF?=
 =?us-ascii?Q?Wox/KI2PpwG0V+xwdVOOuC3NcmQAIdTbZItVtf+u1SZaqHpOkTmXl6TZ3vCn?=
 =?us-ascii?Q?DkXJQvUA5wZbr6RVp1pPOr2eLOWZ8lAvZsqrBBTmiAqcgao8fZLk0++LKlWI?=
 =?us-ascii?Q?Y0pRa6RoX1poRHo5V/TzHMMT92G7w1XHK8CT5/kd5S6tuB2NSeh25eGqeiJT?=
 =?us-ascii?Q?TxtcA965yQ1Ha6PGbJvRALcipEx+Wuyvyft7H8lCdoz+59YCZCb8FBUPxFTf?=
 =?us-ascii?Q?0YhD52/wZv2GUv17tPx+lRcT+bmMGBMa2OmZfj4nh4Webct/pbpfLZwOB8Ur?=
 =?us-ascii?Q?nqAZRyzxmvkODYRCT1za2+WydcXCKtald3Z6u4jQYOdvgPOD/xNw61UWqsjY?=
 =?us-ascii?Q?T6B0wmUz6evIqZ32OcdQ0B48Ers1CykCgjgH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cI2kGxMw8ybqoQ6Y6VjQ882GddsW/vZ9tL9Ix16vulf5d39A7TmW+Knf2uzs?=
 =?us-ascii?Q?Ssfs5HU3/VCxck/dywd6elG+xa97+n0niuGarcfY/r7o5roSPkO+B/u1+rv6?=
 =?us-ascii?Q?HjpEOVdU2VFOOlfOXcHzlyhZyvdRv3RRIQDMwDoj4ZEARzjzmPWDnKeVEqxP?=
 =?us-ascii?Q?+hLFxYxwkEbqOLnCN7YaZepYydHhU7+sX8OavUo78b8l6upOwQj4XFgnuOPR?=
 =?us-ascii?Q?6a4QGTANt2y/jyRwBgo4lHqo6rpCYQLFYr4qG+NAk68Bzhi90mSvNbEONoXD?=
 =?us-ascii?Q?HFRDRMToK5CR6rG4rcLv9bt3skEpYirVAjGEDyTeFK4efNeQie4Sc29JR4Jt?=
 =?us-ascii?Q?qB/91HgQtYvMKiJ6HLziPO4tsBnmsqnRybyi5C2g81HtV4fISliCsF3ODGBg?=
 =?us-ascii?Q?/5Ccohbz6RbNFkqDUeyGgXAIcc0xtYa954B/5jHRzlx5g0pic50nd80xp5eZ?=
 =?us-ascii?Q?cre9HeLaf5k7l5m7CJh+v2NG8NAQkFQN+DieTzMY2P2Xuzpb38oPG5DZbyg1?=
 =?us-ascii?Q?qPuztYmvCU1LEgdLe7CkhKpv2Lfe+HoSB0MEEme/surS8V5Ivcyt7GnNRwOH?=
 =?us-ascii?Q?U66DSKCrlgmDun+QmqZeVTdyzaw90rJmpyqfS12iB4OE/P/wiU3x+oJSJ3B9?=
 =?us-ascii?Q?y4sV4w8N16dI3soi71g2rd1KpDxY8FuCcBQQcnxhXeyu+6LmQSH6U8tsdfn8?=
 =?us-ascii?Q?yk3ty+xbnVbw7w7F6u/UYYEOO1E8KKDgSaTAZd93Uhe6ysY02mTjBM3oMCVr?=
 =?us-ascii?Q?mjYh3XU0cmovOUPh3ZFg/tY2YGbEy81P3fJ3vLf9AlRgBWFza48fNajYA4zB?=
 =?us-ascii?Q?XZaDS9BVXlQw7Czo2JQiX7j4o3o8FpGwmlEXiNjO9CtyecNgUJZASuKOZCdh?=
 =?us-ascii?Q?AwATrEmv+htz8hXjlu3Um2x4cZKtLzk+faiiln1tCpzvwCMasLAG5zTQD17l?=
 =?us-ascii?Q?XqxXggEYEoXFeN33xWsPqiqo8EGHrL3hBlDLIWyPp8h/xuiN/FsMawrPSBqt?=
 =?us-ascii?Q?F5TZF6pLN55MVg6C/jmfags/z3R/ouakBtXuZmIhRh6XUNpBVHkGEwxrzppD?=
 =?us-ascii?Q?7ROq7fKLdcwiPgdR8FTe8jAQSct6IcHcvD6jKQ2kQMe6cAvMto5a3c19oWFG?=
 =?us-ascii?Q?VYv3gz+7gBtelyaR/B6o0n32I4eZxvjp8rwRcLtyM05271+O/40hqGoHQ2VG?=
 =?us-ascii?Q?MZVYeNFJl4WlC+g2YHCBMC22qV/e1XnJAHW5fB6aXKPsSPIWMyjjzl+LcCTJ?=
 =?us-ascii?Q?69J3GweNM9+dWMxNXULsE2V3qjEtIHSk7VsRWco5sdIPoVQ7HtQOC3aqyp3J?=
 =?us-ascii?Q?mf9BFSvJaKBKnUC+j9mzTKy5cEy3W0y9qvhdhP+UBQdaWLRXYgHKshQi0MBO?=
 =?us-ascii?Q?7ruoZpNWU3g+JzM+0jhxELpUxyPqFammb75yxbrN2OlWGD3GIOehkTaA8McG?=
 =?us-ascii?Q?HWaUabpRPMhrIhqXXnYKvl9mH+W9fYhM8pGuEk9HDZhBrNML3hJpIPHnkEln?=
 =?us-ascii?Q?ClOXwZDGk/peMJTuWHgHlbpIZWsc8Nz9IgKll3aNb445R27YNQwBZigbRgy8?=
 =?us-ascii?Q?W/0oz9b7jmxJC20Sh8g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec56bcd6-60f1-4200-c931-08de3bcea6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 11:39:48.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLGeVpJ7BSPMhzOhpJ4oZ9/UXJ0/CR4JGnAXTy91bmDkxgPBAwhclAPmJ4XDlHJ+CSMgXUVBmsgeBT+gdkdcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn

Thank you for your illustrative inputs and suggestions.
Please find my responses inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, December 12, 2025 11:38 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v7 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Dec 12, 2025 at 05:50:55PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> > ...
>
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>
> > +/* Synopsys */
> >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> >  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> >  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
>
> These should include "SYNOPSYS" since they are specific to
> PCI_VENDOR_ID_SYNOPSYS.  Add corresponding XILINX #defines below for
> the XILINX VSEC.  They'll be the same masks.
>
> > +/* AMD MDB (Xilinx) specific defines */
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
>
> Looks odd to me that PCI_DEVICE_ID_AMD_MDB_B054 goes with
> PCI_VENDOR_ID_XILINX.  To me this would make more sense as
> PCI_DEVICE_ID_XILINX_B054.  Move it so it's not in the middle of the VSEC=
-
> related things.
>
> > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
>
> It looks like this is related to the value from
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG and is only used for Xilinx, so
> should be named similarly, e.g., DW_PCIE_XILINX_MDB_INVALID_ADDR, and
> moved to be next to it.
>

Agreed on renaming the variables to match the name with the product vendor =
rather
than the product owner to maintain consistency. The local defines will use =
the name
DW_PCIE_XILINX_MDB_<VAR-NAME>. The

> > +#define DW_PCIE_XILINX_LL_OFF_GAP            0x200000
> > +#define DW_PCIE_XILINX_LL_SIZE                       0x800
> > +#define DW_PCIE_XILINX_DT_OFF_GAP            0x100000
> > +#define DW_PCIE_XILINX_DT_SIZE                       0x800
>
> These LL/DT gap and size #defines don't look like they're directly relate=
d to
> the VSEC, so they should at least be moved after the
> DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG #defines, since those *are* part
> of the VSEC.
>
> > +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID               0x20
>
> DW_PCIE_XILINX_MDB_VSEC_HDR_ID is pointless and should be removed.
> See below.
>

Agreed, this will be removed in next revision.

> > +#define DW_PCIE_XILINX_MDB_VSEC_REV          0x1
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
>
> > +static const struct dw_edma_pcie_data amd_mdb_data =3D {
>
> This is a confusing mix of "xilinx" and "amd_mdb".  The DEVICE_ID #define
> uses "AMD_MDB".  The other #defines mostly use XILINX.  This data structu=
re
> uses "amd_mdb".  The function uses "xilinx".
>
> Since this patch only applies to PCI_VENDOR_ID_XILINX, I would make this
> "xilinx_mdb_data".  If new devices come with a different vendor ID, e.g.,
> AMD, you can add a corresponding block for that.
>

Agreed for this, the variable names should have relation with the product v=
endor
rather than the product owner.

> > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > +                                          struct dw_edma_pcie_data
> > +*pdata) {
> > +     u32 val, map;
> > +     u16 vsec;
> > +     u64 off;
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
> > +     pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability
> > + DMA\n");
>
> Perhaps reword this to "Detected Xilinx Vendor-Specific Extended Capabili=
ty
> DMA", and the one in dw_edma_pcie_get_synopsys_dma_data()
> to similarly mention "Synopsys" to reinforce the fact that these are Xili=
nx-
> specific and Synopsys-specific.
>
> I think the REV and LEN checks are unnecessary; see below.
>
> > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > +     map =3D FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
>
> Should use XILINX #defines.  Another reason for adding "SYNOPSYS" to the
> #defines for the Synopsys VSEC.
>

Agreed, for the reason mentioned above.

> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +     if (PCI_VNDR_HEADER_ID(val) !=3D DW_PCIE_XILINX_MDB_VSEC_HDR_ID
> ||
>
> pci_find_vsec_capability() already checks that PCI_VNDR_HEADER_ID() =3D=
=3D
> DW_PCIE_XILINX_MDB_VSEC_ID, so there's no need to check this again.
>
> > +         PCI_VNDR_HEADER_REV(val) !=3D DW_PCIE_XILINX_MDB_VSEC_REV)
>
> I know this is copied from dw_edma_pcie_get_vsec_dma_data(), but I think
> it's a bad idea to check for the exact revision because it forces a chang=
e to
> existing, working code if there's ever a device with a new revision of th=
is VSEC
> ID.
>
> If there are new revisions of this VSEC, they should preserve the semanti=
cs of
> previous revisions.  If there was a rev 0 of this VSEC, I think we should=
 check
> for PCI_VNDR_HEADER_REV() >=3D 1.  If rev 1 was the first revision, you c=
ould
> skip the check altogether.
>
> If rev 2 *adds* new registers or functionality, we would have to add new =
code
> to support that, and *that* code should check for
> PCI_VNDR_HEADER_REV() >=3D 2.
>
> I think the REV and LEN checking in dw_edma_pcie_get_vsec_dma_data() is
> also too aggressive.
>

Agreed. Revision and header check will be removed.

> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -179,12 +318,34 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > +     vsec_data->devmem_phys_off =3D DW_PCIE_AMD_MDB_INVALID_ADDR;
>
> Seems weird to set devmem_phys_off here since it's only used for
> PCI_VENDOR_ID_XILINX.  Couldn't this be done in
> dw_edma_pcie_get_xilinx_dma_data()?
>

This will be moved to  dw_edma_pcie_get_xilinx_dma_data() function.

> > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > +
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > +             /*
> > +              * There is no valid address found for the LL memory
> > +              * space on the device side.
> > +              */
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * Configure the channel LL and data blocks if number of
> > +              * channels enabled in VSEC capability are more than the
> > +              * channels configured in amd_mdb_data.
> > +              */
> > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > +                                            DW_PCIE_XILINX_LL_OFF_GAP,
> > +                                            DW_PCIE_XILINX_LL_SIZE,
> > +                                            DW_PCIE_XILINX_DT_OFF_GAP,
> > +                                            DW_PCIE_XILINX_DT_SIZE);
> > +     }
>
> This PCI_VENDOR_ID_XILINX block looks like maybe it would make sense
> inside dw_edma_pcie_get_xilinx_dma_data()?  That function could look
> like:
>
>   dw_edma_pcie_get_xilinx_dma_data(...)
>   {
>     if (pdev->vendor !=3D PCI_VENDOR_ID_XILINX)
>       return;
>
>     pdata->devmem_phys_off =3D DW_PCIE_XILINX_MDB_INVALID_ADDR;
>     ...
>

In the above suggestion, having dw_edma_set_chan_region_offset() in the
current function makes sense as when checked along patch 2/2 of the same
series. Moreover, the function is setting up some offsets, doing so in a *g=
et*
function does not look justified just because they are related to same vend=
or.
Similar thing is being done when setting up the ll and dt virt / phys addre=
sses
In the same probe() function which is after *getting* the vsec data and
then *setting* up the next data based on the retrieved info. I also followe=
d
the similar approach, for Xilinx, of *getting* vsec data, *setting* up offs=
ets
and then move ahead with final *settings* of ll and dt regions.

> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> > +       (kernel_ulong_t)&amd_mdb_data },

