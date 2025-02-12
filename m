Return-Path: <dmaengine+bounces-4425-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFDA3237C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D940163633
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D52080EB;
	Wed, 12 Feb 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YX062vrn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YX062vrn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012004.outbound.protection.outlook.com [52.101.71.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E82AF19;
	Wed, 12 Feb 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356199; cv=fail; b=dQXySaY8xhz5KNe1KnBjBGq1ri4KORbbn5Uos6C4F1wVNhMNniJa1+b3igHbF7cEdv66fnjrbFasD32pdxGIa4ZTOGvyAKMHc25nD7zq2OFw/7KvPd7uDvhZqsGRkwZk7g9kqfU+xa/ZHxguzJyntavq5eqxklna+NZZTji2SLw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356199; c=relaxed/simple;
	bh=2paBeqUu5Vlx47pireifYavzOT/qeFVVMI3gwLjCQOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=npKsQOoTyvkUEyaijumFGtW5c4Sg8dpwqxmrKlwfga4wCag6v9asBtNXPiqeCpKYMZcuHJkpHPeFuMNcrEqtipOZDtUvkEn6/opuiBaqXc3zm1nESYSxdn8DAv9MivS4W10wHIQXYCNBIfmXM6l3UddySDMWh2Vz2vfQiNojDT8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YX062vrn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YX062vrn; arc=fail smtp.client-ip=52.101.71.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QfKZhP0smy4kyxIbs2o0bRAkCpSUEfXNzmuXE0SfPIbnx8TrhoSCA42U3S91NxKUq3hMnTvnCPoMpZDVdXGgxKMRyPmUASqyIwqfsvtPZf1uCBslbIC8sluIjp2MhAtnVr8Zh7lrfyupB6NwaEFWXq4IeKaj5PDHKYyDcQGJSd7Xx5kOjjnblergrX/dLzK3+Q4steiP/xYXDHDXNigSiVWgf7jgRn25IciqemygG1fR0D0W9MF+5u+8wndUbtCYVXw2DZ0zuQN6RG/OtMlJk03D3JfgNDkP5Rm46Pgu6r5+SgmG4zA3Rc4BJIskp0+qcaGvjtXVUsjnQ0GV59XAKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/D4REZg/vZys6vAoYvItBGIfiRfDS0UyGfk8fk3G/E=;
 b=gw36fwhynt4D/iURBlBA+5gf5dReoTlgnXClouwLD9t75h6TK4v3+Wssgm2VYiePIRJBeSP2xQdbsjV3ues8TKbHtrKA5S84WSillgzrnDOy8XB8XJnCFGGbeavfaAyTGZSZ2MnBLb9T/+v6mBKIEghU3UjBhkUjDKd92eCFMVLLz3/xc27p6AAY5q7UxJLewpk4b50L5/2ryvX9mzkxuHoKB+miU4E1iL07GiiinsnBeBS7Fr/UrnavJGKZ/AWMfa2rYMU+xE+2wsWq8E+YP/OV30Z4U0AT93v8OafQ4tO0wVJvzvJmJYaZnMJwo8aBdkkcDes8RJHQ99hdesWLCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/D4REZg/vZys6vAoYvItBGIfiRfDS0UyGfk8fk3G/E=;
 b=YX062vrnQFUks4o3xlKfkZkd5mXP4dpNnlKNmPgn0R8AtJr3I3Rq0da1e0+1waV3tt3fdE1kU2L9ICCUKugZIPjA2LQoCmx7GmsWrTe+P4t/ktE6Nt3IVjH1Li6wmg6RfYPoxlRZx9fpVKGipy4NurzeFARJxzSeyFTeZXzy/+E=
Received: from DUZPR01CA0255.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::27) by AM9PR08MB6259.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 10:29:47 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::f6) by DUZPR01CA0255.outlook.office365.com
 (2603:10a6:10:4b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 10:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 10:29:46 +0000
Received: ("Tessian outbound 4fd325905615:v567"); Wed, 12 Feb 2025 10:29:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4f356090565129dd
X-TessianGatewayMetadata: jpiB1WD/lQwSfYnk5y/KCz1pJF5Fr91gON+p7GZChpjeSvVsH4AB5zFjW5hD8rYO9XTjK4K22cSh+4f0HSQJpcX6RTBXA6skxi4CyWCVNnTvZIhJnsAT+/TxKaolmiwhsI+IQV4ao/3SZSgQrxWmGVhGwmawi4WVSon2Mcmn0F0=
X-CR-MTA-TID: 64aa7808
Received: from L9a14846fdea7.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 60517810-50C4-4AF0-9EFF-E33B587F7AF7.1;
	Wed, 12 Feb 2025 10:29:36 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L9a14846fdea7.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 12 Feb 2025 10:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVYmfOTn7TMXztZ17ykn/yhjZapJ+SxDWXMUGK52XQpHL46zXZXJuBv4Iu11DoYf4g/s8hUcep3yDE7R5zoUEwXSIR0FKKB2ubIPk1Xj+U8qSW7NHl2w+VUvEddqhESE3PVz3e6o9QRER0wpiBZiD+DRnYHhOSENMaL9elUx2gg8ZRRTth3qjvJ0tLtabYixf0Xp27HbdeG18a1ClBhNeMlhHVjasTejrjnDe49WoaJoKS3WhCHH5vaQivduSyl++favGOR6juM4OZ8INC4PEsNRQ+jq0GBAnrR4gb3VrIsCcuWzRW6hUh22oJ91zsSv0rxUYLo35k+3IjkZwcVQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/D4REZg/vZys6vAoYvItBGIfiRfDS0UyGfk8fk3G/E=;
 b=fPwVnmxcb88HdIPirAczjghfE8RDkUtFnCozsXatLc7Y3HQ3NT36JEtFoI79yFR+QUtvh8ZQUI55jb1HUyG18gUcLVpIUZAl++b86qgj4e4lFUXC6LZFSlcmMuEpN/DQRXPCWTH40YqasJgRVCT93trXysrSUbRk25B0ivY+HrpPzDqi3rqtTf/vdy/03/8CDucSh44TQY15VR3nhFMKumGPnSN3/aQdDqSZmBn/Rew06UDn6pzXUlh6J+8gw/25UD8miqiRXdVAuU4NdwjNmODDeSffPUz3xNAtPFRwnRT3o6BjBwip0B8ilPzKexcqO+RJH5eM79O4aRP/vFL+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/D4REZg/vZys6vAoYvItBGIfiRfDS0UyGfk8fk3G/E=;
 b=YX062vrnQFUks4o3xlKfkZkd5mXP4dpNnlKNmPgn0R8AtJr3I3Rq0da1e0+1waV3tt3fdE1kU2L9ICCUKugZIPjA2LQoCmx7GmsWrTe+P4t/ktE6Nt3IVjH1Li6wmg6RfYPoxlRZx9fpVKGipy4NurzeFARJxzSeyFTeZXzy/+E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by DB8PR08MB5515.eurprd08.prod.outlook.com (2603:10a6:10:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 10:29:35 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%4]) with mapi id 15.20.8445.011; Wed, 12 Feb 2025
 10:29:35 +0000
Message-ID: <8ee8e684-0164-4e70-b42e-3827c7885685@arm.com>
Date: Wed, 12 Feb 2025 10:29:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Content-Language: en-GB
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
 <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
 <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
 <fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>
 <20250212-naughty-chipmunk-of-potency-7e0ced@houat>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <20250212-naughty-chipmunk-of-potency-7e0ced@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::25) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|DB8PR08MB5515:EE_|DB1PEPF000509E5:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 57588999-8aa2-4c29-3ad8-08dd4b502c4c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SXVFNEZFOXZ4bWRMT01UWGdVV3ZreW0wcWJyUW9kaTNqRmU2N0hjYk9vSW9n?=
 =?utf-8?B?US9nQzBLWmlkalh2Zyt3UWN2d0RucG1YMlBQL2ZIL25BWTEwL0NVUWpVTFQv?=
 =?utf-8?B?eURnQXRNZlQ5b2ZTWU5QdjNRQWxic3lKWFpkd1Vyc3ZlS2h3elErdi92eWty?=
 =?utf-8?B?YlBvTk1hWnhUTG1ZU1p4SnVoVHBUU0dLR3pCVElvYS9VYUw4Y3ZVWmhPc25t?=
 =?utf-8?B?dGFmZlpPT3ltVGNjcmlRam14Mm1aNFlRSWlqeHAxam05dVVKV21qSnAzdTFO?=
 =?utf-8?B?a3d3blF5UCtoQ25LakZ0RHhOdUxZd2tmRENGdlhQdEtKdUVlemo1R1FnZ3dx?=
 =?utf-8?B?SXlMWkJmOHhlNjJ6Rk04Z2ZNV25Fc04yTCtFSWlnT0ZOb2JaMnk3bTlMeGtJ?=
 =?utf-8?B?V0MzN3FTN0FtZWVjZXJ6R0dTL2dleXNsYUpjRmc1TExxVDZyMFV6TDJod0dm?=
 =?utf-8?B?TjRIZDZHQUpDaXRZcDZVblVCZUxUT1oxY2RLY0RLSVRBeWRFQnpKOFZtVEFH?=
 =?utf-8?B?T2JuZDJrdjNGaFFBeDhhMW1FZGtGOHZERUNGbk5SWmZmTWw4TE5KejE0YURI?=
 =?utf-8?B?dUJ6NTE3b0poT0Fybmwrak4rNmpLc2NnRDl0ZFIvbmhhVzFGbC9GdnVDUTJ6?=
 =?utf-8?B?UjB6cnNOVFJUQytjbzZzM1J2TjRJeEJ1eVZoeDBWOFYwVS93bDU3Zk1pcXdM?=
 =?utf-8?B?NjNRdUw3d091SHlMVUl3cmhuTExCVXpNSGNuZGhDTFkxZkJ4emo5TGo3MElU?=
 =?utf-8?B?YkN3QWZDcm5jdWI2OXh0b3FpOGFwalFMeE5TVXg2dElnR0JTRCtRbnV0d2x3?=
 =?utf-8?B?RUlrNHFqUkdJTVljVmhYcnNMaEFWL3A2UEtJV25ERnZQellMNWFuMllKY0Q0?=
 =?utf-8?B?V1NwVkRESTVjb1IxL3R5MTNtMTRMeFA4S09aWHhaeW1jeFBFMGdUUmFMbitT?=
 =?utf-8?B?TjhBQkE5WnUrSjFNUWNIV1JoZ3JZbGplSUwxMllPM0FmUkJEM2ZFMnA0cGxi?=
 =?utf-8?B?bkxwOEk5NkV3WlBFRkN3dm1wWW54VS9vdVc3WXRGaEdBY096WTlCamU5aitC?=
 =?utf-8?B?U0pMbkhsVUF1NFJQV2MwZmlmZ1M3YU9sUFVtMitBZDVlaC9qdS9USTJFdGli?=
 =?utf-8?B?NTZQWFQ3THRYd1FKRDJBUlhvWHhuQmE5bTJZM08rK0gycjJsajFzaWJJR1VG?=
 =?utf-8?B?bVRPVlRBT2k3ejBsUkd3b1VQNnZDay9XU2lSZkg4bHhnNWx6ZTZzekY4Y3dL?=
 =?utf-8?B?ODM0ajdhMnRIbmdjMCtPaC8yOTdVaitJS1BHV1R1RGc4bm5menJXNzdUaDZZ?=
 =?utf-8?B?bWUxZW1UU1VIR1oxTTFFZHFaV2dPcERnSUFQTWQ0QVVUVXNGNG53dHFOSTlN?=
 =?utf-8?B?cUNwenBPZnZyUm9KZEJCT0VlRUdzamFqZnMrdjdIMUR6Z2lmSzFCdzlRR2h0?=
 =?utf-8?B?U0JSQU52MUNKMDNlN3dXbTRxNlkrdkRqbzllQStQdzdKMW9uWFZmbjdTRURQ?=
 =?utf-8?B?YkdvSUlMTm5kNXZCeWg3a0VBS0lqSUY0eTNFTm42UzhEZjVRMUVwZ1JML1ZH?=
 =?utf-8?B?QzFGNFNiYXNQOHBrMmNLWFBJbUZQMVJnaU9nUjVsSDRhZU1kQWZoTnBncng1?=
 =?utf-8?B?dGo0andjbkVsK2FUMERSVWQ5OHhpejJEY1pIRkEzOVVwQTI3eS9iTkEwLzh1?=
 =?utf-8?B?NTdBRm9UY1JWdnJOU2ZBVXl5N2xRSGplYXh4N1J0Y0J2TmllR1Z4WGd4V2I5?=
 =?utf-8?B?cHhrMktMY2tuajRDV01CdnpBc05wWlhVT2RXYTFlang5TGVVTUo0NXR0WnRK?=
 =?utf-8?B?eWt3U1pTZjlyMkFhY1JEL1Y4M3M0TE5SOE9Wd24vT1JpODFWSVB3U2FjcExP?=
 =?utf-8?Q?54ItRiX0qWqQ+?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5515
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cce96afc-2fc2-41a4-d27f-08dd4b502509
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|1800799024|35042699022|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpqNktyeVdySmczcnArdHE2VDRFblU0UXlnNkVWb3Zua0Mvb21CN2o4TGlh?=
 =?utf-8?B?MnRrT0E1Q24xaDY2eGZ4T3FVV3E1TEhZQlRManVTZVN1Q0tuY01TL1pyMTlR?=
 =?utf-8?B?VThaelduaTlTaG1heDlzdzJTY2NmbnB1SjNiRXBBcWR3NEpmdGhLeWlUaW82?=
 =?utf-8?B?aFVIdnQvdlhUWnlLM3k0U3NILytXMjl0WmJNaU1JQjVtaUlEZXlUZzNWQjlp?=
 =?utf-8?B?SHdpS1VseW45ZUVMeEpLREFJUnMxWXgycHZoZDExWmJITlFwR3VtenZ6VXdL?=
 =?utf-8?B?Q1k4THNBc21NNDU5YVlPRTduOGhPeENsYldYN3haUXpwZ1U0bHBoQS9lTE5t?=
 =?utf-8?B?WHRXSXFmQ2wveGNGQ1pHOGpyT1YzZldrN2RQN2FEeDFNcVFvem9RaFBGdTJm?=
 =?utf-8?B?QWFRUFFmTFRNditocWJYSXI2MTZsV0RVQ0sxc3doc29pQTdCR0U0R2FweDdG?=
 =?utf-8?B?OCtvVzl1UGpwT0pjNEozKzh2bnNYSDlRS2YzWFMvK01DOXNQR3Y0RWo5a2lu?=
 =?utf-8?B?MFhBSmY3N0RFcUluMytKUEVDOTRsRmZ5OEhpOGo4NWxWQWVBMlBRMmJjNmFL?=
 =?utf-8?B?SlYzU2tqdHFXaE1HRVFMbmZjc3lTR0JOeG9wTE1rdjF6cEMrNEc1K1poSnpX?=
 =?utf-8?B?L1d4ck5qb0pqTG5KOS9WcGNqTUpZSVdSTlAxdXluN3lPZlZXL01TaXZuL3dt?=
 =?utf-8?B?a241OWgwZWFoc0F5QStHcmlFWTZseTdHaXVrSmxmYVN5ZDVMU0JTdHoxNEta?=
 =?utf-8?B?QU8yOW9PN2JoVjVESjhVQTJSOHIzUFFUSk1ZZnQvMk9iNStmTlNjbklLd2sz?=
 =?utf-8?B?dHZtL0FBSGRiQ3RrSm42RWFtR3d6SFBSaWNMRUFQYUV0cndheWhuZWNremtX?=
 =?utf-8?B?OEtZM2tsVjhEdkpzMGZyVktveTVIb1FXWGVycFlEQjJUWENRVlFMc0VFMUlR?=
 =?utf-8?B?bXZuMU9hbUNGMnZURkUvMWJ0U0FhZGtkZStrN1FUQm9EdFo1QXVad1RDaExm?=
 =?utf-8?B?bEI4TTJBb0Y4MHVXUmxSSGd5NGdtWDNHZ0thSVhQeThLNkVoRm9FT1hnUXla?=
 =?utf-8?B?eTFYYlJuV0kxVTJXRlBkbjg1NzZGRVp3L29zTzE5cWZWQ2ErK29icHBtV2Rj?=
 =?utf-8?B?UjRhVU55WmhQTGdLQ1FUR09IZDFBN0lhbEpHemJxSytvMGRVUDFZUDdndFhJ?=
 =?utf-8?B?ZVRQaW9TdFl4dUsreE4wZXJaN2ZlUWN5ZDJZS3MySXY4RUtwV2JXSXVWTG53?=
 =?utf-8?B?RlV6aE1LVGJUazRSK0FPTTlscE9CUmwvbzFCb21PTGV1VkNGaThxU3JkTzdS?=
 =?utf-8?B?ZjA4cXFaYXc5Q3pLK2dEcm1ZVHhHdlB6NXg4UDlCNDBKM2cxUWZiQ2l1ck5F?=
 =?utf-8?B?d00zWlQxazJLZXJ6Z1RGaEJWQmRnQnMyUVBadnNMMWZBcXNLSGpadWkrVjBv?=
 =?utf-8?B?UDdlUnN0WGd2V3UvZTRnOWw3cFRkMVp1QUR0cFkxVXU5VC9ld2E1RXlpQ3Jx?=
 =?utf-8?B?ajVJS1M5OFErT2MyWjh5ajEvL2lMRHpsV3ZtSDhRendJVFZnay9ZQXZPSitV?=
 =?utf-8?B?dDFmRUxOWkJnQlNMcll5ekc1eTNwZFVTYkVjeGJ3K0Y2aGZVVUQ0V1BEZUI3?=
 =?utf-8?B?OGV6dy91MDl1SnBGS3JYK0tVbUdwYkRHR3A4ZTZOVEVmbzRUTEFkR0Z6L3B3?=
 =?utf-8?B?Q2NhbkV3YUxiVDI1b1VCcklMNVc2dnRPMTNVZnpuL0wxdzNjM1BpR3g2V2V0?=
 =?utf-8?B?ajVMOXlVeWVKNmhBYWpBYzJadHhuTHNVbFM4cnJQck9aYTZKbWxQZTZ6bEJS?=
 =?utf-8?B?Qzh3WGRUSU9QRS9QSExUblF1Z1EyeDFZd0dOZmJwazdXbk82dTQ1alVFc1RF?=
 =?utf-8?B?ODdQTmFVL0xGSHNhSXVSWDNjbHg3RVUrTVdnVkJ5Z0YvbjB5OTJwNzRHSlNK?=
 =?utf-8?B?QmNjWkQvaDhIYmdubklOTjhQRzM0VGtiaE1YejJMaGhHUUp4dVZhcVVGVEVi?=
 =?utf-8?Q?JlarwUx4bnFbFua4zvWsApHUTOgQFU=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(1800799024)(35042699022)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 10:29:46.8826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57588999-8aa2-4c29-3ad8-08dd4b502c4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259



On 12/02/2025 10:01, Maxime Ripard wrote:
> On Wed, Feb 12, 2025 at 09:49:56AM +0000, Florent Tomasin wrote:
>> Note that the CMA patches were initially shared to help reproduce my
>> environment of development, I can isolate them in a separate patch
>> series and include a reference or "base-commit:" tag to it in the
>> Panthor protected mode RFC, to help progress this review in another
>> thread. It will avoid overlapping these two topics:
>>
>> - Multiple standalone CMA heaps support
>> - Panthor protected mode handling
> 
> You keep insisting on using CMA here, but it's really not clear to me
> why you would need CMA in the first place.
> 
> By CMA, do you mean the CMA allocator, and thus would provide buffers
> through the usual dma_alloc_* API, or would any allocator providing
> physically contiguous memory work?

You are correct only the CMA allocator is relevant. I needed a way to
sub-allocate from a carved-out memory.

> In the latter case, would something like this work:
> https://lore.kernel.org/all/20240515-dma-buf-ecc-heap-v1-1-54cbbd049511@kernel.org/

Thanks for sharing this link, I was not aware previous work was done
on this aspect. The new carveout heap introduced in the series could
probably be a good alternative. I will play-around with it and share
some updates.

Appreciated,
Florent

