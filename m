Return-Path: <dmaengine+bounces-8367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C7D3A277
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8762305E445
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD9352F8A;
	Mon, 19 Jan 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vCI2CUgv"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAB352C2F;
	Mon, 19 Jan 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813762; cv=fail; b=dwM1wIgTQktY7nqB272bTS0ih/gU/v3seQ1BSBA4hp3/5ismhFvnd5FV+/G55p5OXAX0nDxAhd99uCXU1lqpomc110DcxKl3wE5X7kzeZoIowLceq7iMt1ZkqMCcLExUNz6UthVQ/4ENuu2MmI2GtL5dwv2qBVuJKjdBicbo6iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813762; c=relaxed/simple;
	bh=kcV5i4gNEzjY4u0TGDTdvkMaps7up55DrqImOoP39DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GFg6UV+dzSD9FIrIomOBgw8w4iIYqmBKrRv7TXqAnI5bjfdaM8Fqv+qiFwjdsjBHPQHALkkPmb5/CaEVM2LF1kPS+xiDctes5znwplRja6eTaBkjlFsOTWeNc78WAMQ56xuOzxmPnnhERxVF53pOUB8MjSZ7lG+sJ9JwHcWz/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vCI2CUgv; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzwYUAVSbhNRAraT17fl0GA1i1eaT83L9/bx56MtkdsuWXY3lbGNRfNtSYXzMTief6uwR0PyJNM/3OrNMHt6L+4WnebTkD1K+vLG7pT+LDcxXDtPExUslmy8Vhh/efM5NWlb/CYxaHO4CO2K8bu+L4jnTGiun7YXHkOLxPl6R/JGIC364kJoxP0pXGOTqA3lGzbYqCOjywc/8nQ9/tlmozKKqNelI1VryB/MNYAPKSwaOL1pVj33oHNnIdq8uRtoPJo3sjD0/Dp0z/sqseCh58xLKzAi/muDv3uMkjy82C6k6G5jv5kkk9lpEQbwU/kWKVuZu/5H8zmsxoXh2Bnrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9M/0ZhlSjPNk28CVSzYJEHduUbZSocmFF9cyVBUq1o=;
 b=uUouSyygWjCEVr9/+ein3z2X9twQoKiAPaBJ5QBGjkgQF6DuVnWuMb37dyF37rUhJIfAKtXtamtP9HF5Hlvg757GnVU4uA3iYoXiBgqLQN+iWzXwvTpipHpHa6JcyRqbcdNJB4OyrK0K2awO4L02W+jy2QX0TK+BbgEZ8L6akwy60yxgaDZXRrQfyJRTP8kkF9CDvGVAYhgpWv7RPzTRlI+EZl3tQS6n2D22mU5RrOeNzuTSY1XVO/k5aoS9swbdfD6kYE2HXmzz/Ec9JIuvX7dHwHA9AyeG4ElHJCyCQWoi0aNGETfVYPDcZ3RSPsKoo8+V4PwsgRMJFfvVecdWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9M/0ZhlSjPNk28CVSzYJEHduUbZSocmFF9cyVBUq1o=;
 b=vCI2CUgvbLKulYy9n23b+YjN6+oazfs+VTtgDIaDrk4sPxcJnxmdB9hxbNdLSraBTlnaqBbKY135vUPylmc8PvA0xCo/rEV6l/TxgppRM7p/9GkIoUfC7+eBAu8JWKhjQHYhNaRGbE81WrYzhqcpnDh0EWKye7a1MZcqVcrit1Q=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:09:18 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:09:17 +0000
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
Thread-Index: AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OA=
Date: Mon, 19 Jan 2026 09:09:17 +0000
Message-ID:
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
In-Reply-To: <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-16T11:10:04.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: bfaeee6c-242e-4955-bf42-08de573a6ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NF9zQs8mhg1NfAqs9ZuuWkB6IeRUVuEjH0hKetCa8UnKLO5Tnfy1NSBVDClc?=
 =?us-ascii?Q?RvUvPgRQSuilWC/kQyH8wPPfm2d5xBnTcYnLAGuyWjmETtNdqI6RCVCc0IVw?=
 =?us-ascii?Q?4hNm+8+SFDUPWXvawOEKZLv5FY/f2GztAKI0BN/gWAgye4NZBS4P/oy6xubj?=
 =?us-ascii?Q?sEdC93ULa8oXumIwbAIC+07pwchxTozoEdUnLJQ7DrCoQSXxu/b1HpEnbtKO?=
 =?us-ascii?Q?YAoC6U8M1tRoP8IbR9vqYq0CofbdCjP0gxERjNMKCMh+aUeJDQ1rHXUJELDE?=
 =?us-ascii?Q?uDZjPL4/5amphwsdCus1thXgxVuDv/Ra7pF4ibtoQkXNqLKMgen8lN1ZdccA?=
 =?us-ascii?Q?f6MfBZp18w/qvsS3QoEWkvrkhMTK/Ge+O37cx3ezx1jfQ15QHIkCJ7D78JxP?=
 =?us-ascii?Q?FBSN5dgowi+BWdD7NHz62IWqh031GlsCeWbHk4YSIExPm6ccSCWUn55PSF58?=
 =?us-ascii?Q?fXDWmVttb/LLFEdupOE82jrr+KTC2eC3UuIFKUG0cyAqVUlyneWKvyUDFWjE?=
 =?us-ascii?Q?pwWFxZ6Nmjto2/S4RyFI4TUbxhXaFaGHzkdZN/JbvdA+m88/qfZ1a57xZhvF?=
 =?us-ascii?Q?oRd2t48mWcuL9APEAhkAz8ArROeBvsBCmrOf8oeViqiyZ9jIV/nTQeWx7GR1?=
 =?us-ascii?Q?eGV20/Qp4rb3b+C/KhZ3gTwoQ57TOXh7eif2bRgi2mnjbHmrrS6bceA604mD?=
 =?us-ascii?Q?OioEPiNHCrS9WspD2762zMjz58ijwVJrj/8YCC2BjmUHyPoeAlGXgaed6laU?=
 =?us-ascii?Q?HCzBI1YM0y6DaIoE5yfgWmPLOhdL7z+4GTfZYM1zObdF0LKUKrPpr0Vr0Wse?=
 =?us-ascii?Q?BJ2nV4aUSakW7qK+/wwxdxSPeyE2QYpdc7uPslSMcpI7FyZLKmkym8S8uSWv?=
 =?us-ascii?Q?pZgSeR0XMPhUc2Nqh+n4T5fafY8zzy9Wrb2nQXoAY1He1kllw3hy/32L5CC0?=
 =?us-ascii?Q?pkDH+RWwpGMX83opqQoYMWHPmXZ2rLagysKpakEIww2/OCvU9C16SUR8hNOd?=
 =?us-ascii?Q?fgCfSMEXWN1wORaSp0vVRxraifwqLu6xhhP/OdP+MUJKr42fyHnD0Wec6iHK?=
 =?us-ascii?Q?lrUsbr9/bOmzJj6a0P9aXeK+TOgFV4+8Sdg1yWcwo/VNZpxZhQ/0LrcZQS1L?=
 =?us-ascii?Q?hYgTK4A9XEMYAX6z9ObjvZwiS8ntsZfyD5jmiCB08o8I3mr4GfTqPI3Uui3j?=
 =?us-ascii?Q?7TbUGp0BaFbZLT6A/0FtwnSkGhLkbtDNVCWgN7xkvBVbZQBdFlmh+2wYRQuk?=
 =?us-ascii?Q?c7yPrQJwcjWc8GzHbkDBjOqI0wtt5bhcs5xHrEYqkA9raEwbtWVJ73SWjRWu?=
 =?us-ascii?Q?hAqspE7qdkpos9gT9b44E3+x6brqP/KYY4dfrEAgzmyjrjRQanam3I5lP9nK?=
 =?us-ascii?Q?3wb7UwSHVVAdFHpHYmfO4qfIDxjnlRStMa7u+yB67ukudP9DWt+1KxUs8/Ek?=
 =?us-ascii?Q?xbuIEHDNM8k1c2GT7bAnKZ7K+A0sxI6u+7GU7SJyUVQ44VD1d2VIoR7v4O1w?=
 =?us-ascii?Q?O0+ntrMI1SuqiiX2lDzYAs+HISqz/6+e/bU1t4SJHDQU4eEcFsOAr2LEcW0Z?=
 =?us-ascii?Q?CamUr/G0ygLyVcEU8bEUjLak2rUGaHb2Q/oHjSkF2AdCukrdR6rK9bAzFQHk?=
 =?us-ascii?Q?/E58VXaCof67M7oNl48/D9o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b9J1Bl3jgWPSrig0KEIf0duO1sjHrDwaURd8H6vm6PXsVjjDxfSdhB4rmMCy?=
 =?us-ascii?Q?70Ji1HdErMaJEJ9nH68mBV/oEeNHB3IzZVNqI6SANmlltqC75/JP3pkvlC96?=
 =?us-ascii?Q?xL5xA4KaWyeytk4HRuuJ+i6xEWm6fzPL7jm+i8KmGRVGwpHTq16TMORpvyd5?=
 =?us-ascii?Q?cLPKV0n8JgAVXjYhZNfDCrl+4Qyl+HSDbNrM9qtSoSQd7fyZyHNHR5JEKTIU?=
 =?us-ascii?Q?BE2Drxlw1evBRTFb1cWnM2h7bhfeJ5Eiob/Et3yK7XKLnUSBc0S7b6gL75bu?=
 =?us-ascii?Q?vHfbJiaeKkm9XWccMmaHHkk24aa7F0oLtmdbaaCLVoStCPWiAiAl5yCIhJRB?=
 =?us-ascii?Q?/Jm+fKpTVhxNW0Vi0EmGd5+w2rIuNSJRvXD6zNwMb0Y2nbxeN8UqTmE3Gh73?=
 =?us-ascii?Q?ehHKl/YXtcBGatZ3UR0ieVoDFNbalbJKAdkPcRbUJUHT0Autwgwme49ypjql?=
 =?us-ascii?Q?fTTcZm2n54t5k4G72lRE0JYMvc4oc2EkSc4xkFP83XBRrTJPkSQfdIRAAjcX?=
 =?us-ascii?Q?XrK7mDK3xzM9P8BCUzCpNXBEwUmelLRxI+cheJF7ZMg0GwhjvOP4++UBEJQQ?=
 =?us-ascii?Q?OnJrd/xOs5SiqpsOqvMZkPTXO5lYJ8eP9FxT78/ciRHTFTPQxMiV5AhFO+GW?=
 =?us-ascii?Q?IB4p6KhagHXc4KIXiXxJ8NsN9oa4AyMwe6wDY3x58A8fjKof0YVTxJB4XgLi?=
 =?us-ascii?Q?wTODNXcHzWZMOx7JrwrowqPzRi9Z/XBd4sodDMVPH6JhefAXtimIkZFq0cHr?=
 =?us-ascii?Q?BRFqYz4A2I/9uEK7eY6Gl+DSgLdtOxKIzeZJrMSCKIekyLYYgjH/lGr9/zuz?=
 =?us-ascii?Q?Cnr+u8wcFthl6IE8XNgYPZNg4A3ohjNjuF+Ip02m5z9/5/s+fT5Z9TTzDk3q?=
 =?us-ascii?Q?hXFsQKpjviEZ59cqAUqzPkam5qPvtaUQMvTs9agdKXDZharABRuo3uqI3Faj?=
 =?us-ascii?Q?1+dYmg5002NryPaXAA++LO7ALh8YMEp0y8ouAj3mHhgfPLGZb+WQmC9t1rbc?=
 =?us-ascii?Q?Nc18S3xsfJ4XkXEVyf9psXkhQPXR43VT/WZf0eKrA4j9olxVqQvUzg8q5L98?=
 =?us-ascii?Q?cYlbeRq6hb3foPf7Y8pTS28CnQGIrAS44z09M/VT2tLrV3f9WRUFywuv5j+v?=
 =?us-ascii?Q?LYbEhmq/4hn2QAaZNCKksI5ziW9zqf9NQpj+BPHFbt2kxK+T6yzo0gubdOSY?=
 =?us-ascii?Q?sff+1EM+Q31lxrBj8nwy6TDsFuNU2sZ2GJan6nNGq1CcoD9B8okWOiD92C2B?=
 =?us-ascii?Q?spDXBRvrUd/AY9oX67Z8u8LwWgqYyns/j0BBDKxL3PbUF6N6ZCUdbVfj0dFX?=
 =?us-ascii?Q?y3IFDLvEVjcmx7et2T5kqhYsYgL/KeKrcJv1kR2bLo7GoitmLYoIWB4knhR3?=
 =?us-ascii?Q?8jp1GDTnDEVtIlf0mZmb7vQ/SEZh7L1HZ85sCJpUD0RHtulbNgJ6eNXeeK62?=
 =?us-ascii?Q?u/wLmBbjOBYB27AMY6pNz5o/kX/BsIZZ6q/aSfF2jIpvScfWPWDZKLe0GYh0?=
 =?us-ascii?Q?FTUIrtGFgE6ujsQ2g4o4N+0StcZ+7tQ7AuTQ1zkvaDqzF9t7Ln24/5VrE86S?=
 =?us-ascii?Q?mQuLKxW85dMEf0dJhkJBVW8hpVRf8d39bsWcTxh9VJ8J4gd2Xw9TA3phk9Mg?=
 =?us-ascii?Q?4RPYwXtLhkdY+oVckU1PlR5v0hun1bHn0cF4j34h+bXdalgcawmoycTNCYez?=
 =?us-ascii?Q?0xjCIc77AnxO0SdVYUsv28r6Oh4TebBrScrwN6GJNQGLc4MT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaeee6c-242e-4955-bf42-08de573a6ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 09:09:17.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8UekDj03wJdpnoJFJRbrIWL5fKIlPnuncPU8by79OwbT2TEslB9CG8wBkv3zy0MzrijtSoVDFP/b1SMnIBPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Please check my response inline.

Regards,
Devendra
> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, January 15, 2026 10:07 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - For the AMD (Xilinx) only, when a valid physical base address of
> >   the device side DDR is not configured, then the IP can still be
> >   used in non-LL mode. For all the channels DMA transactions will
>
> If DDR have not configured, where DATA send to in device side by non-LL
> mode.
>

The DDR base address in the VSEC capability is used for driving the DMA
transfers when used in the LL mode. The DDR is configured and present
all the time but the DMA PCIe driver uses this DDR base address (physical a=
ddress)
to configure the LLP address.

In the scenario, where this DDR base address in VSEC capability is not
configured then the current controller cannot be used as the default mode
supported is LL mode only. In order to make the controller usable non-LL mo=
de
is being added which just needs SAR, DAR, XFERLEN and control register to i=
nitiate the
transfer. So, the DDR is always present, but the DMA PCIe driver need to kn=
ow
the DDR base physical address to make the transfer. This is useful in scena=
rios
where the memory allocated for LL can be used for DMA transactions as well.

> >   be using the non-LL mode only. This, the default non-LL mode,
> >   is not applicable for Synopsys IP with the current code addition.
> >
> > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> >   and if user wants to use non-LL mode then user can do so via
> >   configuring the peripheral_config param of dma_slave_config.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v8
> >   Cosmetic change related to comment and code.
> >
> > Changes in v7
> >   No change
> >
> > Changes in v6
> >   Gave definition to bits used for channel configuration.
> >   Removed the comment related to doorbell.
> >
> > Changes in v5
> >   Variable name 'nollp' changed to 'non_ll'.
> >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> >   Comments follow the 80-column guideline.
> >
> > Changes in v4
> >   No change
> >
> > Changes in v3
> >   No change
> >
> > Changes in v2
> >   Reverted the function return type to u64 for
> >   dw_edma_get_phys_addr().
> >
> > Changes in v1
> >   Changed the function return type for dw_edma_get_phys_addr().
> >   Corrected the typo raised in review.
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 42 +++++++++++++++++++++---
> >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46 ++++++++++++++++++--------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > ++++++++++++++++++++++++++++++++++-
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>
> edma-v0-core.c have not update, if don't support, at least need return fa=
ilure
> at dw_edma_device_config() when backend is eDMA.
>
> >  include/linux/dma/edma.h              |  1 +
> >  6 files changed, 132 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > b/drivers/dma/dw-edma/dw-edma-core.c
> > index b43255f..d37112b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> dma_chan *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int non_ll =3D 0;
> > +
> > +     if (config->peripheral_config &&
> > +         config->peripheral_size !=3D sizeof(int)) {
> > +             dev_err(dchan->device->dev,
> > +                     "config param peripheral size mismatch\n");
> > +             return -EINVAL;
> > +     }
> >
> >       memcpy(&chan->config, config, sizeof(*config));
> > +
> > +     /*
> > +      * When there is no valid LLP base address available then the def=
ault
> > +      * DMA ops will use the non-LL mode.
> > +      *
> > +      * Cases where LL mode is enabled and client wants to use the non=
-LL
> > +      * mode then also client can do so via providing the peripheral_c=
onfig
> > +      * param.
> > +      */
> > +     if (config->peripheral_config)
> > +             non_ll =3D *(int *)config->peripheral_config;
> > +
> > +     chan->non_ll =3D false;
> > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll)=
)
> > +             chan->non_ll =3D true;
> > +
> >       chan->configured =3D true;
> >
> >       return 0;
> > @@ -353,7 +377,7 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer->dchan);
> >       enum dma_transfer_direction dir =3D xfer->direction;
> >       struct scatterlist *sg =3D NULL;
> > -     struct dw_edma_chunk *chunk;
> > +     struct dw_edma_chunk *chunk =3D NULL;
> >       struct dw_edma_burst *burst;
> >       struct dw_edma_desc *desc;
> >       u64 src_addr, dst_addr;
> > @@ -419,9 +443,11 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
> >       if (unlikely(!desc))
> >               goto err_alloc;
> >
> > -     chunk =3D dw_edma_alloc_chunk(desc);
> > -     if (unlikely(!chunk))
> > -             goto err_alloc;
> > +     if (!chan->non_ll) {
> > +             chunk =3D dw_edma_alloc_chunk(desc);
> > +             if (unlikely(!chunk))
> > +                     goto err_alloc;
> > +     }
>
> non_ll is the same as ll_max =3D 1. (or 2, there are link back entry).
>
> If you set ll_max =3D 1, needn't change this code.
>

The ll_max is defined for the session till the driver is loaded in the kern=
el.
This code also enables the non-LL mode dynamically upon input from the
DMA client. In this scenario, touching ll_max would not be a good idea
as the ll_max controls the LL entries for all the DMA channels not just for
a single DMA transaction.

> >
> >       if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED) {
> >               src_addr =3D xfer->xfer.il->src_start; @@ -450,7 +476,13
> > @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> >               if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
> >                       break;
> >
> > -             if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> > +             /*
> > +              * For non-LL mode, only a single burst can be handled
> > +              * in a single chunk unlike LL mode where multiple bursts
> > +              * can be configured in a single chunk.
> > +              */
> > +             if ((chunk && chunk->bursts_alloc =3D=3D chan->ll_max) ||
> > +                 chan->non_ll) {
> >                       chunk =3D dw_edma_alloc_chunk(desc);
> >                       if (unlikely(!chunk))
> >                               goto err_alloc; diff --git
> > a/drivers/dma/dw-edma/dw-edma-core.h
> > b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9..c8e3d19 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> >       u8                              configured;
> >
> >       struct dma_slave_config         config;
> > +     bool                            non_ll;
> >  };
> >
> >  struct dw_edma_irq {
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 2efd149..277ca50 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -298,6 +298,15 @@ static void
> dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> >       pdata->devmem_phys_off =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->devmem_phys_off;
> > +     return pci_bus_address(pdev, bar); }
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -307,6 +316,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       struct dw_edma_chip *chip;
> >       int err, nr_irqs;
> >       int i, mask;
> > +     bool non_ll =3D false;
> >
> >       vsec_data =3D kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> >       if (!vsec_data)
> > @@ -331,21 +341,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> >               /*
> >                * There is no valid address found for the LL memory
> > -              * space on the device side.
> > +              * space on the device side. In the absence of LL base
> > +              * address use the non-LL mode or simple mode supported b=
y
> > +              * the HDMA IP.
> >                */
> > -             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > -                     return -ENOMEM;
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> > +                     non_ll =3D true;
> >
> >               /*
> >                * Configure the channel LL and data blocks if number of
> >                * channels enabled in VSEC capability are more than the
> >                * channels configured in xilinx_mdb_data.
> >                */
> > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > -                                            DW_PCIE_XILINX_MDB_LL_OFF_=
GAP,
> > -                                            DW_PCIE_XILINX_MDB_LL_SIZE=
,
> > -                                            DW_PCIE_XILINX_MDB_DT_OFF_=
GAP,
> > -                                            DW_PCIE_XILINX_MDB_DT_SIZE=
);
> > +             if (!non_ll)
> > +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2, =
0,
> > +                                                    DW_PCIE_XILINX_LL_=
OFF_GAP,
> > +                                                    DW_PCIE_XILINX_LL_=
SIZE,
> > +                                                    DW_PCIE_XILINX_DT_=
OFF_GAP,
> > +
> > + DW_PCIE_XILINX_DT_SIZE);
> >       }
> >
> >       /* Mapping PCI BAR regions */
> > @@ -393,6 +406,7 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >       chip->mf =3D vsec_data->mf;
> >       chip->nr_irqs =3D nr_irqs;
> >       chip->ops =3D &dw_edma_pcie_plat_ops;
> > +     chip->non_ll =3D non_ll;
> >
> >       chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
> >       chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt; @@ -401,7 +415,7 @@
> > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       if (!chip->reg_base)
> >               return -ENOMEM;
> >
> > -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_wr[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_wr[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_wr[i];
> > @@ -412,7 +426,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
>
> This change need do prepare patch, which only change pci_bus_address() to
> dw_edma_get_phys_addr().
>

This is not clear.

> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -421,12 +436,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> >
> > -     for (i =3D 0; i < chip->ll_rd_cnt; i++) {
> > +     for (i =3D 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> >               struct dw_edma_region *ll_region =3D &chip->ll_region_rd[=
i];
> >               struct dw_edma_region *dt_region =3D &chip->dt_region_rd[=
i];
> >               struct dw_edma_block *ll_block =3D &vsec_data->ll_rd[i];
> > @@ -437,7 +453,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               ll_region->vaddr.io +=3D ll_block->off;
> > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar)=
;
> > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      ll_block->bar);
> >               ll_region->paddr +=3D ll_block->off;
> >               ll_region->sz =3D ll_block->sz;
> >
> > @@ -446,7 +463,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
> >                       return -ENOMEM;
> >
> >               dt_region->vaddr.io +=3D dt_block->off;
> > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar)=
;
> > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_dat=
a,
> > +                                                      dt_block->bar);
> >               dt_region->paddr +=3D dt_block->off;
> >               dt_region->sz =3D dt_block->sz;
> >       }
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index e3f8db4..a5d12bc 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> dw_edma_chunk *chunk)
> >               readl(chunk->ll_region.vaddr.io);  }
> >
> > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > first)
> > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > +bool first)
> >  {
> >       struct dw_edma_chan *chan =3D chunk->chan;
> >       struct dw_edma *dw =3D chan->dw;
> > @@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
> >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > HDMA_V0_DOORBELL_START);  }
> >
> > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> *chunk)
> > +{
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +     struct dw_edma *dw =3D chan->dw;
> > +     struct dw_edma_burst *child;
> > +     u32 val;
> > +
> > +     list_for_each_entry(child, &chunk->burst->list, list) {
>
> why need iterated list, it doesn't support ll. Need wait for irq to start=
 next one.
>
> Frank

Yes, this is true. The format is kept similar to LL mode.

>
> > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > + HDMA_V0_CH_EN);
> > +
> > +             /* Source address */
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > +                       lower_32_bits(child->sar));
> > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > +                       upper_32_bits(child->sar));
> > +
> > +             /* Destination address */
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > +                       lower_32_bits(child->dar));
> > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > +                       upper_32_bits(child->dar));
> > +
> > +             /* Transfer size */
> > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > + child->sz);
> > +
> > +             /* Interrupt setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > +                             HDMA_V0_STOP_INT_MASK |
> > +                             HDMA_V0_ABORT_INT_MASK |
> > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > +
> > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > +             }
> > +
> > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > +
> > +             /* Channel control setup */
> > +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > +
> > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > +                       HDMA_V0_DOORBELL_START);
> > +     }
> > +}
> > +
> > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > +first) {
> > +     struct dw_edma_chan *chan =3D chunk->chan;
> > +
> > +     if (chan->non_ll)
> > +             dw_hdma_v0_core_non_ll_start(chunk);
> > +     else
> > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > +
> >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> >       struct dw_edma *dw =3D chan->dw;
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > index eab5fd7..7759ba9 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/dmaengine.h>
> >
> >  #define HDMA_V0_MAX_NR_CH                    8
> > +#define HDMA_V0_CH_EN                                BIT(0)
> >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > 3080747..78ce31b 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> >       enum dw_edma_map_format mf;
> >
> >       struct dw_edma          *dw;
> > +     bool                    non_ll;
> >  };
> >
> >  /* Export to the platform drivers */
> > --
> > 1.8.3.1
> >

