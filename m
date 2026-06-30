Return-Path: <dmaengine+bounces-11888-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 522kB/W2Q2qqfgoAu9opvQ
	(envelope-from <dmaengine+bounces-11888-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:30:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B136E42F0
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:30:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=bs2iV1f6;
	dkim=pass header.d=ti.com header.s=selector1 header.b=sQJ8jcAQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11888-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11888-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 777DE305DAD4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616851FBEBC;
	Tue, 30 Jun 2026 12:30:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2BD145FE0;
	Tue, 30 Jun 2026 12:30:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822640; cv=fail; b=dLERWzXl0HCtSXKZDQ4T/cXAX+EP/3OeV2C/H1Gwwlrnlz6/yWM4qFvGuPf332LOcx/bsTdKS+dB5p55QoNr0Bz90qEsXOjyrYid4V6KmpwWIB0vwGFKRAxkALy0DJ3pOnzntphKIQD5TqS0zBUawil9QBjqKNhXF4KEEzI+Th8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822640; c=relaxed/simple;
	bh=5fdbmexkp+tEE1voq98ZUdXpRnfHJBukYFAstSJRW1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpLjQIWi4Kj8so/O78KWZEx2fOUIJMp5qWls9PhzEmCriyyoNqSmk31yqPc6yjTyLHU3Bufs4o5mmv2kth84i0gg8BiU78vgzgXe3C9dJdz2aBbR0pQ/FeFj4ozX3APayxWvnQwcCzsGLL7ibfv0Ik/mJMOr34Ir8fZLEIZktG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=bs2iV1f6; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sQJ8jcAQ; arc=fail smtp.client-ip=148.163.154.28
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UBAoit676857;
	Tue, 30 Jun 2026 07:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=d6d9GoL2Cwba4zKt6lgX+OEUKmVmYsV6rK0N9Cwpp
	5A=; b=bs2iV1f6acC9A2B+V4NebiB/lbq2FfSNj/n0KVHd8YsN+lgUFImFz0L9n
	6+b2dBX114YOkJ+S3wUhNjkvxu7IhMLVM7u7WADqTyRwXkwB4Ox2qVUhH0H7nVvN
	TA+WhGoapeMVyFk6RTYZOHG5umAgGP4VvLVe+0EPM9dNAaIc759KL4q7i8TAswpr
	8YIVxmpdNe0EOnQakxfMQGc58IKOGEY/VXVQagdfV3ekktQUhATEAkxAaiJ/VNyM
	9kQUvY1spQOqTXF8NV0uw3QuV9iQJT0NjfJ1gd+rQxDTk5icPwTJYXa0jz/1PQjc
	gYzyB0nO5qvsA/RPbe4JZ0iF1AyjQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvrb25-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 07:30:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaCRMckbfQJyHv3UXsKtfq4A9PvLu8jCAZXdPHvwrHnE8xjCROsfcW+CjEBtGQ/6MIH/yFh8QBIlcIZse0vB5l9vV5NTWU4L7EN/jhxZulKKuXYZ13yfVcSc3FdOae61pW9TlKCuQpw7kMAAXUaaj7Bvr2SyMo0wIGLnQqDq91EQew/KHjCNaYhA4AOgTMRmiBUK4BnijKpUlcf5MsRtbC8InDN/hYBwtHE6SN7zQ1r9cVvOh/Tk09kNyG0mnQbOyjblBS108hsjiMYEdTFwlwtV7yNyZ8m424LSfdxjmv5KOGrRCz520tFrV/S3XQgsptWp+xH7WbtagwQ+OskO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6d9GoL2Cwba4zKt6lgX+OEUKmVmYsV6rK0N9Cwpp5A=;
 b=iXuZQzDb4PYZBLjjIQFHU65tNbrxV+OZdi5ixcgJxEMa/Yth/Y8JIYb4yZYinmq+u+mltf78kSHEDrsm1BWNX/GNc2TNRtRWfTq6Y3ht/rvcJ0c3EpU7ylIufqVJ+Vtg6Viq8sAHabBGJppL2uEpQS/pfdDv/LHxric5i+cQgjjy+oQS2R2wGa+2k8VHToB9nL7p/Idj4CCxp73hSHLsIRWPzjenKwggqgPyS8V/vz09+tkvJiy4B7CQGKCPsGDHBGlu0Go3PlHnOxVf+YBZKZaN4vAr5JeJqOS081V5cPkxdNKAYENdEo75FgqDFzOC+/wJH0AoNVod7MmaoZ0xvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6d9GoL2Cwba4zKt6lgX+OEUKmVmYsV6rK0N9Cwpp5A=;
 b=sQJ8jcAQKVFhu5TOAhPoUQmhedoGIbPL5Hs6Eb93n/Nv23xJZPTjTysltl9YttfTEg2WFPtcC2n5vLch35xBu4Wsbt6Q3E4P/v2ozqZNk1EupzcU8mIrf8NOre0jN9po75KOFQzrrN0n/rBjKkGEr1HlSNTQYh+7fmcJ8M4SVfE=
Received: from SA0PR11CA0182.namprd11.prod.outlook.com (2603:10b6:806:1bc::7)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 12:30:29 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::81) by SA0PR11CA0182.outlook.office365.com
 (2603:10b6:806:1bc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 12:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 12:30:29 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 07:30:29 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 07:30:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 07:30:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UCUTQJ3055883;
	Tue, 30 Jun 2026 07:30:29 -0500
Date: Tue, 30 Jun 2026 07:30:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <dmaengine@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li
	<Frank.Li@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
Message-ID: <20260630123029.ozveska7eoenci3s@unturned>
References: <20260504031209.618949-1-rosenp@gmail.com>
 <20260506110910.su2s6ncsi2xfdiwm@pureblood>
 <CAKxU2N8PUdxo54oHtcroqe+Q88k0obxPg_9OCRsNsoOwvcS25Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8PUdxo54oHtcroqe+Q88k0obxPg_9OCRsNsoOwvcS25Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: f6287067-4c4f-4aa2-e635-08ded6a35f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|1800799024|376014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ER+IewTJFiqXNnBougqfSr8Saj9TN38WjrH1PwY5OmFlSeVXuzqUvLVkgi/0sCL7Mqp+Lknel+PLEO8NvkkWdRJs+88tINXiEZBpji1Wrw9+J2p8V0GuhZbU4dBXsV5eoduYMebs0X7NiQ6pzqDfu/HIEzQiUYBcBtRIERjyzmkC5TussZ7r2+JcHhtOKSVmltMkb9UW7IZCWCzX26v5b6ZsuCJoZmb1lQ1eAGpwxWSUqVEGhk+SLpuclpxxhciIuHfdR2jKoslZJNUph9IyOnVoiWJBWWYW75L9raiLE4v5mca2wFVnyg8Q7y6anFtvy+KIjLvACjx/X5RsN2XahxXw9JXERP/lUdxNH/EZ2YizEHnOa7qbrRqT9ZEqc+ksktvCbly8jauCv2166FtQp55494f1E2b0cbBCNketTzdCY6eRWQwpDlRq6QunS7vZs0aRU6NRfZkFebHdvBNKtqxxgskoGWGSdwthN/+7Hl3xywyaLvJ/ryvNJI4XfoSQ9Sjg6pjqrNbIoDJgZ/kBlRXInpl/AAHriVkFo4uTBWwTJ/mefQPy93DZKpPVwvT3yZcLH9dom8J+wZ9mYNYputva9BIa06nQMg9NxC06LFs4CC7jlaNPtOoE/stVRYscs7gI/MXt1Z/Z7yOb0Sbzfg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iDiusGzsgOekt0q6eRBejNHUnA/1pHjSghzfzvS7TzfWKCdkUtpLutcB5X15ioyskbmuyiL80uTCRqW+d45uFpk9VkNzqj6Vv2qHSRkqphnkpaLIpCqscwQo029bYwXxCyNNGET12qCp7XAoA9YafiKyTYw5jhVsoL3Fq8bUFxva59WYSFDKAHgUpLzGNmjKisudGdUfkBdDoD4sdGc7i2d49tLU/1JBpCCMJuXGkBodjE9gsL+3fh8uurXlasgxat0gRvFGhV1PhIgJ5QKd0VfHB+mO1FAS+S4eg958VTg4hiKIYcepx4QdnUyoJWOQjut+lFIYTGYhd7n4uzwY+Iq2jfCG+ZgNdh7oV4S4jujXJe6LepD8TnXW1egQ7sTfdXbm8XZlolOrf4JYIvqK7/5FlPq4iT8KTGMVfJ2NNDhsGcS5MU2njtAZlX0Z3Ktx
X-Exchange-RoutingPolicyChecked:
	eHpkXLVlWYJwiUKQm4XC8M3DEjanElFi0rvuKf7f+tSd8h2SAPRlT1HlKdLTQJmWMLuOc3v6/haKQoDsgyqmfdcJ1UNUaV9NX4odYSD9bumpalw/lLwUlPfrQryb/tuZAY5SotxK61rlCH2BukrDHHhYlGVUcr2PvjTQcYIJSnjmjnDAqo+xJNzK3zh99nymevtY6bsEGea1p2vWBvyZb/tkaao8Uz8dIsuKr7vYhT3SCNONPA7H/F5crddmtAU0S+D1ynXB9ZRkPleMzk43WSNXg41njSj3L5vAloliA+Gke/zM6Od9gD3XMrcrEjk6n+e2MFVgVQvWm8Oxke1PLQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:30:29.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6287067-4c4f-4aa2-e635-08ded6a35f20
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a43b6e7 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8 a=P6EMeZrB4Hkf_tHIvukA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX3oW38DbELDzQ
 rnAnbYhsUvXvjVDZpYV0JirWFl18ijm/0efMGfNdVy4gpSJdakac9zv6UdpyHuGgZoHhZh8++d0
 OSBVg1b9HLI9AUtvdd+xYpsYjPtCwVg=
X-Proofpoint-GUID: AUJbHr8712Ya2Z3BhOcOGjXC0wxnXKBb
X-Proofpoint-ORIG-GUID: AUJbHr8712Ya2Z3BhOcOGjXC0wxnXKBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXyV+HUHAns43D
 pKjy10ptW/V/KEdoOPgLY6Iu2uE99j+Qbez2dsCa3j2EqKeqJUrZOx4I1zzEfDY8QL61kq2RWEC
 bK0EE2NXN3GMnYzvmRSK9eMTNUvzLd2Q4qoyajg+QzdLVhlvjrXa+Cd0HuUAGTjxQ9jdBjakszd
 wapLQhxHq39xxXQSCBF5JS7id/qgbhIy77+U96I1r95kCUAKhr6xPRDN/GdhcvGRJsABBxUyzag
 /Y1dqOLbul8pxzS/YnPMimMJl+PGsyoGTSkQ87XIru2QFBjwNjsoq4K1dKBNy2c7gJQXz2wBoie
 1HQW2ZZu7Uvphotti3db8uwgV+z3NT0y8/y/q0TVlwL9apMKEZH+Hv4jWK4U0E+LZd6qWmo4HDk
 y1VZrabLTZJGs71zh1d0ABW1Dv0Zl87CnVabZpSCfwaaqHPeFe4yJOhBfA8k8gKeueE3fC2tEsf
 3kuJJlCeSmDrfSKEqnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11888-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[nm@ti.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vigneshr@ti.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kristo@kernel.org,m:ssantosh@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ti.com,kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:url,ti.com:from_mime,unturned:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83B136E42F0

On 18:42-20260629, Rosen Penev wrote:
> On Wed, May 6, 2026 at 4:09 AM Nishanth Menon <nm@ti.com> wrote:
> >
> > For some reason, replying drops the CC list. manually added them in.
> Found the issue:
> 
> https://lore.kernel.org/lkml/20260630014129.1548147-1-rosenp@gmail.com/T/#u


Please repost with additionally CC LAKML and the TISCI maintainers for
the patch, this would go through my tree.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

