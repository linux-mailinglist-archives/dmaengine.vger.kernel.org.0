Return-Path: <dmaengine+bounces-6044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B757B27977
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 08:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521681897781
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD922C326D;
	Fri, 15 Aug 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="NpniwH/P"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0929ACC4;
	Fri, 15 Aug 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240705; cv=fail; b=pSFVqV8xwxlTOLrZSstkUFeWtvVh6Lzquaz8CgepaEupNFcPVlk5HmNlJE9FeaDOdvctF0OWL11gvUpoP0qI3HuCMSUdYQerH5zYJMIwHUyEc0pCNZkTy3Knywz7le0masLuY3wlotXmc58DPIQCTomw+/AjuKyOXggbHyqkS+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240705; c=relaxed/simple;
	bh=38+H+JSBmaDdUcZzrKk2MIgvzEdKDFJoJ960Zaq4pBY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XnGjl08ki3KafSFcORYuiVUZx+MkTpzwJG5LSoiMtgKrJhpU9T71p1svpEWktIPhs+U0i29+WZ2fAzrzrtGN3fGpinkpYdkGMgNK35ecWbv3pgVZBulPBae2Uf5kvqVlWRz4TzrdZPYz43XJHQFDFvqFvep48YDYFFTYsz1mghc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=NpniwH/P; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC0k5WzFAIRmzogzXGmvnKQ2Nql9UpUqqUYpX5/QyABq4PZjC9d7TeBvC+lKVg8/QqAhZV4ivhLti//gqYwL8mz4hwtayFa2uRcQz5ue3RTH11t6Eboa/ytf6WUevWnkauBh/GcIBEQ/mNUxZgJpDtkRRPiLSwVNQEhUyhh6IRpLZySmCbzMXhJsc255rvGYxMRJGFy9VkEV3jz/nLEP8xYc86FKLNFnTZtSqM6dM3OtlzBbAXDJCIFMLoqvBOJ518Ml1X0FoEVjM0uY9DCR7gMu6TtDgPa3Vob9PKJ57JiQ3t0aEF6ZpCsfyjbLcJ3gC3WQd4MtSfKfQ283rzgsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38+H+JSBmaDdUcZzrKk2MIgvzEdKDFJoJ960Zaq4pBY=;
 b=RMQoseuzKmMsda5NDN2ttA6teZF29cubRp7KNd+PrSHQ5aECzO+HWvI2xaNJSUFrLBwQC9vTX+j1tlU8gDC9LwwrOingPW9L5R+xmsi2FJu4GwecwxzEdUuIkzucA+b7jqPn1hPPxgpDxRtoOlEfBtSbKsEulh2vAyo8cxmFXzWOyukIBz2i0nygAqSuxxnysYSLSJDpFRE3JVt2x1GSg0mM3fiIN3MpISdRelh3xWTsOPvUauiwIE/kY74gi+MaIelWnHcK8tGr3bLhevuT4znr8haazS5QjSD+6uz5bSwLshKzJha73C+iIUI6JZY4Q4ioX4nzCIoL81aKluL+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38+H+JSBmaDdUcZzrKk2MIgvzEdKDFJoJ960Zaq4pBY=;
 b=NpniwH/PzV6kVJsTNactglJp8PwXnkEU2nChnAL2DwmnI9XBPmXCN7e86QcmAEY/aFh+FjtkjnQgEDesuHwVb4En779LZw2+HKlV8HeEuEA72zDiwqHWuTM1W7zZckgNVt6UuzEWc6Tza/Al450JRkVSBATx60voTFg5i5XgD93dR5DlteikXPg4ckBTvdVhQdaQhEi1H4W8bWvIZrKZ89aVh8/6nI5wJjN5h6PIiDUL1tb6wmqqjIWs6MPNGx5vCZ/aZ49AZYWvIcsBtcl16/VHsCTmq7+ebCMaATGjQN5PgC+Z1iqn/RxWxehkDwqzjJaj9srwVD472pVWUHHXRg==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by DM6PR19MB4373.namprd19.prod.outlook.com (2603:10b6:5:2bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 15 Aug
 2025 06:51:34 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:51:34 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "kees@kernel.org"
	<kees@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"av2082000@gmail.com" <av2082000@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dmaengine: lgm-dma: Added Software management
 functions on HDMA.
Thread-Topic: [PATCH v2 3/3] dmaengine: lgm-dma: Added Software management
 functions on HDMA.
Thread-Index: AQHcCBPRskvW3gNVeU6wFgvlvyZwZLRYRmKAgAsJrWA=
Date: Fri, 15 Aug 2025 06:51:34 +0000
Message-ID:
 <SA1PR19MB4909614FC967757377DE7488C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
 <20250808032243.3796335-3-yzhu@maxlinear.com>
 <3f1a35fc-7fda-4179-948e-1a2acafd0f8a@kernel.org>
In-Reply-To: <3f1a35fc-7fda-4179-948e-1a2acafd0f8a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|DM6PR19MB4373:EE_
x-ms-office365-filtering-correlation-id: 004f1607-3c71-46e5-20de-08dddbc82c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cG1YOGZvZmhUZlZjTlZSdSsyMDFTOWt0NlVWaDRJM1JaMGJZTWJUNFBjQmNI?=
 =?utf-8?B?dTZzSnhqQTF1eExNSUJGaUFSVkdjdi9MdlJmUlZMYTZLTDgrMEc4dHZJU3FC?=
 =?utf-8?B?RHlFdlhWSjEyZ0xPTDNNZE9GUW1ibzBFdlVoWU9lV0t5cDhsNHI3Y0ZuUkVG?=
 =?utf-8?B?ZjY5WHRpa2NvRXRmbkVQLzRuK2tXRFY3ZjFnd1lFc0I5S29oTURpK0UvVS9P?=
 =?utf-8?B?QTBCTTdGd3kvL0htVmxUK0hqbHM4WUU4ZU9mWFRTendaazlGK3RoeFBXclRD?=
 =?utf-8?B?cnhTMDlDdkxkUmZvQ2FWQkFWMTM0U0JZMmxveVhYb21qUUVOR21hV2RLK2JF?=
 =?utf-8?B?WUs4dEpFbklCSGswMmdEeTk4bVU1T0VnaWFhSzdoUU5ZeGwxKzZkUVdLQnpY?=
 =?utf-8?B?Z3pBcm5YTWFvc2RzNGQ4Qkp5RnhtRW0wNFFJbmZacy9NdXE1VEx0aFN3Y0RV?=
 =?utf-8?B?RUNiVStaeitRc3ZNcWs0OVdQVm9jTWhYallueDFaUlhzSWpkOXl2VWdFT0M2?=
 =?utf-8?B?d0NHd3NiTTJwUkdnSFlQLzAreTN6QnM3TEh1VFVacFBpN3JnLzBVRnB0MzF3?=
 =?utf-8?B?cWhudVgrK3ZOV3JPUkZLVEdsWlRkR2Ewa2NtazRBNWdLcXhMcjhxc20vZmJU?=
 =?utf-8?B?MkYwQXdURVJtZEEyN2ZnYTBrOGlhUU5TZTM4b2xGK0lQa2t0ZmhTOUU2NkFC?=
 =?utf-8?B?cmpRQmdxODluVEFoWE4xN2x5Zk82b01sL1ViSGdFeXY2bmtyYkpNQUZOeFQr?=
 =?utf-8?B?Ym0xQm1abUNMUDdPUUhpWEZiS3c0T29oNW55M0pYVjAxN1l3TkVYTlA4cHJ4?=
 =?utf-8?B?UDJiZTNtR1YyTXZJU3RUVWFuR3A5TFdxY2QyMkF5RVhmaGRWSWVGTDViQXFx?=
 =?utf-8?B?Wjg2OTJkS0RNa2pJZHFIZG45MUs3VlU0NE5NNVByUmw3MVdYYzMxRGZsWVpM?=
 =?utf-8?B?MGw1OGZ0QVVhR0ZUb3ZXWXBvL2xBOW9WaDR4bjh6MCtSUmxSanFDWGE5NWs0?=
 =?utf-8?B?bmJ5M0Z2S3I1ODZXVEtJSUtIVzZIMnRKTFhHcXpuWWdCNkNnZmVRSUQ0VzMv?=
 =?utf-8?B?K0pKdHhCYlo1OWlqUHZ2YTRrd3BoWmVQQ0t6MEs4RUFxNWlEQTJQUUNTRGJE?=
 =?utf-8?B?MmR0cm5FeVFleWdlSWZxTXRKT1dRN0xiQlVRVUZFOVhBWklFQWV5TU5WMXU4?=
 =?utf-8?B?ekduUDJBcXd5TW5FeCtnWUNMakJaTWRON3h1dFgrcHpUSS94Y0M1NmZrTTZL?=
 =?utf-8?B?TWlFallNejRQeUhsSHNvUFdwc09KYm1QL2Qra3l0clEwdEsrQ0t5b0RlWDN1?=
 =?utf-8?B?RGlEbFplNUJZcWRPekplUCtlWi84U3JWemlQTThpeVZJUUJaaEtXb2I3NEdJ?=
 =?utf-8?B?SGhZcVFuQzhzTGtodHFpV1RSRVNKL1lHdU1qbDJwZXBXdDhmUFRSNFh4TThy?=
 =?utf-8?B?dEExWkxkOXhvOVpjbVBGNG1PWUI4K0R3M2Qxelk3Zk1mdC9uU0h0TzlGZkRq?=
 =?utf-8?B?czdYOENxcUdyRkF2WFNLUldxVDZPcmFkL2RIV1F1dThMTnFoMGFtdTRqbExY?=
 =?utf-8?B?TFJWcHdwWXJPVVJzZ2c2Umt5VlRQQVlJYzN0blhGY1JRNVlEaWZVRm1oa0dn?=
 =?utf-8?B?WkNIeDRGZU1iS0wyd0xVOGFyRWVZd2JQbllaaElaV2dHUm5CL1RJSllUaUtr?=
 =?utf-8?B?LzduNDVCdGE5VEgzK3BxUzNnUHgwWUpVNmZIUUdaSGZXZ3RwMlFpNnVwRlZw?=
 =?utf-8?B?ZmlBK3BPTGh4U1JxMk5yZTV5QmRpS3pFQUJVdWxqaTBTQXdQbm5aZTFKbVE4?=
 =?utf-8?B?MTErdmRzTVlQOVRTWUxXK1BlSUZra2RiSnExSzRvMmRCZ2lpUXI3bHFVS0J5?=
 =?utf-8?B?di9TRUx4RFBMQy9mSFBCcHRkVjc3Um1QNVBBRXFPb2xlNUxuUnJ0Z3ZpUm41?=
 =?utf-8?B?WWRkUVo0a2prQlVrZXFGQ25QYVV1eVU5MG5IZnNOaGJWUE5hU2lJUmFvMlU2?=
 =?utf-8?Q?mmJ8sT/OzdLcMYrfBaTV9oXr91gfDM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXlobVFkVHdLenUyR2x3QmhpSXJhQmsxMTJCdEZZbjRhUHVkS0VnL0FGQ2Yr?=
 =?utf-8?B?eXV1QlJCRGdzZStQMThvVDlHc3kvMXVVdDFWWmN2Zm42RjhUcVlrOStDbUVt?=
 =?utf-8?B?WkhDQlFCT21zNWVFajlDQmdqWkFHVy9NV2g2NnpGUzRaOFc2UXYvS3lhSzdO?=
 =?utf-8?B?dlM2N0FweDlTdjBEMERJRDFCV2lzWlFiYmJrazd4TjFUbk5CNzBzV1hlLzQw?=
 =?utf-8?B?WmhtTUFkL3l4SU52RDBjTTl1UTRIWnlpYzRVYlRDeTJVUHpiS1lWY1Q4U2FK?=
 =?utf-8?B?MUFwQUg0ZzRLYWpSY3k2dm9GTVo0TTZYM3JqdkRNbDMzekRTS3JNQ1lzeGtQ?=
 =?utf-8?B?YUZyZ0piMVAyN3pranJEL1l4OE9KdWxCeFo2Yk1kSzVyZTd6ZXJnQndlZHpw?=
 =?utf-8?B?eHozYURCOVB6TW9mRmRwbzk2NHVremttZUxidnJ1VEwrU29qOXNVYUVNTFZ5?=
 =?utf-8?B?TDIrclhZQW1OVnFBQnZFQjdyZ3VvekV3OExQTWg5dzhnZDQyME1kWFFQdHBi?=
 =?utf-8?B?WFptNklTUGxhbk5HdkdoTTAwRXRIT2g0Q2RueG5KeFpCd3NPdExCeGtPMkwr?=
 =?utf-8?B?ZVdwV1ZHK2IxNnVObk11MXp2elZCRm1GcGozTUJOSjJkcyt0SVhzdlA0SWs5?=
 =?utf-8?B?b3B4d2pva0RQVjBvMCtpcE51N3VBL0llS0JoMGZxcWU0M3YzWWFkUWxObGpL?=
 =?utf-8?B?R2dEaXZjZTJmbzd6cDRlc3BqcDVBY0Nxd0h1bkhSNlV3ZDNaams2UmFzN0tz?=
 =?utf-8?B?SUtNUytSZS8wT1Rpa1ZOc0MrazZyZFRKTSttUCtNQ0MzVjJXeXRmcVpneFc3?=
 =?utf-8?B?S2F5eTg0WGxLMEZaWVFNQ2NLYjVNekUrcm85c2tTUWJWOHJVbFNOSUxEbHhK?=
 =?utf-8?B?c2VacTFVRE14YnVLUVlDSFFCZnA0SXhqaUJyYk5jRWZBeTJuU0hxamRhRTU4?=
 =?utf-8?B?VjZLQkh0RmErSW4zTGxuN043cHJxTmFudTh2YktKQW56NjNQNEpmL2IxOWxZ?=
 =?utf-8?B?TTVjTFNWR0hnTXdNVlNKcGRXRGplSDhCWGMzZFIwQVBabXM5b2ZQZ2JlN3ZW?=
 =?utf-8?B?YVJ3bjYvbEptaWgwek1TeWpKNmtLZmJ6UGJBaXJXTUN2VytVUFVGZk5UUmhL?=
 =?utf-8?B?NjJFVjdqU1RjYUNrOXZLSUNDSy9wWWNnSEZjQzE3VHo5bE9Ob0ZodDllTXVV?=
 =?utf-8?B?NmtiNHgvZVFqYjVNVEhxTkZoeEVpdWxRTUI0bXVqTW5FbkxtYWRIbTRyRndV?=
 =?utf-8?B?V05DdlJML2xGbHJNUkZqNS93VkdZR2FJVUJ0N2NYWFlmbjlIenJwT01DQ2NU?=
 =?utf-8?B?WmU0OU10ekYyWkVnVE5oSEpNb2tra2N2T2kvSCtUMGxuVkVQUXQ1WDVSMzRx?=
 =?utf-8?B?b0lTQ292U1NwS2lkL1Z5bFRhOXhsZW9TbzM0ZnZCRUZNLzc2dWhxbXV0OXNX?=
 =?utf-8?B?R3Y0WExPcmtrSWxTOFpMWFNGUzY4OTFid3IrMll1a3AyZGszK1dmS2VJN3Ji?=
 =?utf-8?B?TXEyK1ViSWo0aTVleTFpQjdnanYybFk1K0dJTW91Z3UyZ1FkcjduRGpNSDVn?=
 =?utf-8?B?STYxMmtJb1FXa0owOU8vVHZuZW5QMVBwMHlFR2ZMRHFnUy8zUHRud0lrSkxU?=
 =?utf-8?B?Y0hYV29HKzRBdWVaNTMzb2pLZTNyUWs4YVo2UmcvdzZRbmsrbUhGMzJ3OE5i?=
 =?utf-8?B?VkhmcEtKcC91MXZvOGc4WUhqNEdoMlRSU1lVQ1U4WFJDRnEzaEdJWEZKbDJW?=
 =?utf-8?B?d0RKeHVhcHFJSzkzL21MUFZvc0s2UHVxRGFWZktwREFQU25kbmF4NnlVVTFk?=
 =?utf-8?B?Rk84RTN1bnFDUU03YUc4WXdCdjlGRXJwOHQ2c2xwbk51N3BaV0JzM2JRa2Fm?=
 =?utf-8?B?SDJUREtyY1hPY1Rpb0JJR3V2MTcwVnhhcnFVYWNNbzV1YzdRbVRWRkZNZlY3?=
 =?utf-8?B?bkh5OW1EcCsxZEdYWnhXcGlrT0E2d1hmSjdGQUEzbDMxOElHYXVyM0tDdVRa?=
 =?utf-8?B?OUx3ZXpRd3JnMngvMmJIdTQwN0NPeGpPK1VKRHJWV1J0TGNIdk8vRlZIcFZF?=
 =?utf-8?B?d0w0R1JtNjhqQTJ1aTJ5L2E1VDMrcFhnRTlQRUpSV0UyOUd5bjZNRlFxWFBt?=
 =?utf-8?Q?TyPeja1S7SfWTaMWTWvDt6LHq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004f1607-3c71-46e5-20de-08dddbc82c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 06:51:34.3960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZYL/aVqjBaehA2GiMJNSrDzfsJNnvLmAhVcTOHzLponIGnpAUfPxxvfIV+TWIXb5a+f+oOHL59JfX6G+zq5EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4373

SGkgS3J6eXN6dG9mLA0KDQpPbiAwOC8wOC8yMDI1IDE0OjExLCBLcnp5c3p0b2Ygd3JvdGU6DQo+
IA0KPiA+ICsvKioNCj4gPiArICogaGRtYSBUWCBuZWVkIHNvbWUgc2lkZWJhbmQgaW5mbyB0byBz
d2l0Y2ggaW4gZHcwIGFuZCBkdzENCj4gDQo+IFRoYXQncyBub3QgYSBrZXJuZWxkb2MuDQoNCkkg
d2lsbCBjaGFuZ2UgaXQgdG8gLyogKi8gZm9ybWF0IGluIHRoZSBuZXh0IHBhdGNoIHN1Ym1pdC4N
Cg0KPiANCj4gUGxlYXNlIHJ1biBzdGFuZGFyZCBrZXJuZWwgdG9vbHMgZm9yIHN0YXRpYyBhbmFs
eXNpcywgbGlrZSBjb2NjaW5lbGxlLCANCj4gc21hdGNoIGFuZCBzcGFyc2UsIGFuZCBmaXggcmVw
b3J0ZWQgd2FybmluZ3MuIEFsc28gcGxlYXNlIGNoZWNrIGZvciANCj4gd2FybmluZ3Mgd2hlbiBi
dWlsZGluZyB3aXRoIFc9MS4gTW9zdCBvZiB0aGVzZSBjb21tYW5kcyAoY2hlY2tzIG9yIFc9MQ0K
PiBidWlsZCkgY2FuIGJ1aWxkIHNwZWNpZmljIHRhcmdldHMsIGxpa2Ugc29tZSBkaXJlY3Rvcnks
IHRvIG5hcnJvdyB0aGUgDQo+IHNjb3BlIHRvIG9ubHkgeW91ciBjb2RlLiBUaGUgY29kZSBoZXJl
IGxvb2tzIGxpa2UgaXQgbmVlZHMgYSBmaXguIEZlZWwgDQo+IGZyZWUgdG8gZ2V0IGluIHRvdWNo
IGlmIHRoZSB3YXJuaW5nIGlzIG5vdCBjbGVhci4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQpUaGFua3MgZm9yIHJlbWluZGluZyBtZSB0byBydW4gdGhlc2UgY2hlY2tz
Lg0KLVcxIGdhdmUgbWUgd2FybmluZyBvbiBsZ20taGRtYS5jLiAgSSdsbCBmaXggaXQgaW4gdGhl
IG5leHQgcGF0Y2ggc3VibWl0Lg0KQ29jY2luZWxsZSwgc21hdGNoIGFuZCBzcGFyc2UgZGlkbid0
IHJlcG9ydCBhbnkgbWVhbmluZ2Z1bCB3YXJuaW5nLg0KDQptYWtlIENST1NTX0NPTVBJTEU9eDg2
XzY0LWJ1aWxkcm9vdC1saW51eC1tdXNsLSBDSEVDSz0ic3BhcnNlIiBDPTEgZHJpdmVycy9kbWEv
bGdtLw0KICBDQUxMICAgIHNjcmlwdHMvY2hlY2tzeXNjYWxscy5zaA0KICBERVNDRU5EIG9ianRv
b2wNCiAgSU5TVEFMTCBsaWJzdWJjbWRfaGVhZGVycw0KICBDQyAgICAgIGRyaXZlcnMvZG1hL2xn
bS9sZ20tZG1hLm8NCiAgQ0hFQ0sgICBkcml2ZXJzL2RtYS9sZ20vbGdtLWRtYS5jDQogIENDICAg
ICAgZHJpdmVycy9kbWEvbGdtL2xnbS1jZG1hLm8NCiAgQ0hFQ0sgICBkcml2ZXJzL2RtYS9sZ20v
bGdtLWNkbWEuYw0KICBDQyAgICAgIGRyaXZlcnMvZG1hL2xnbS9sZ20taGRtYS5vDQogIENIRUNL
ICAgZHJpdmVycy9kbWEvbGdtL2xnbS1oZG1hLmMNCiAgQVIgICAgICBkcml2ZXJzL2RtYS9sZ20v
YnVpbHQtaW4uYQ0KDQptYWtlIENST1NTX0NPTVBJTEU9eDg2XzY0LWJ1aWxkcm9vdC1saW51eC1t
dXNsLSBDSEVDSz0ic21hdGNoIC1wPWtlcm5lbCIgQz0xIGRyaXZlcnMvZG1hL2xnbS8NCiAgQ0FM
TCAgICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gNCiAgREVTQ0VORCBvYmp0b29sDQogIElOU1RB
TEwgbGlic3ViY21kX2hlYWRlcnMNCiAgQ0MgICAgICBkcml2ZXJzL2RtYS9sZ20vbGdtLWRtYS5v
DQogIENIRUNLICAgZHJpdmVycy9kbWEvbGdtL2xnbS1kbWEuYw0KICBDQyAgICAgIGRyaXZlcnMv
ZG1hL2xnbS9sZ20tY2RtYS5vDQogIENIRUNLICAgZHJpdmVycy9kbWEvbGdtL2xnbS1jZG1hLmMN
CiAgQ0MgICAgICBkcml2ZXJzL2RtYS9sZ20vbGdtLWhkbWEubw0KICBDSEVDSyAgIGRyaXZlcnMv
ZG1hL2xnbS9sZ20taGRtYS5jDQogIEFSICAgICAgZHJpdmVycy9kbWEvbGdtL2J1aWx0LWluLmEN
Cg0KQ29jY2luZWxsZSBnaXZlIG1lIHNvbWUgd2FybmluZ3MsIGJ1dCBJIGZlZWwgaXQgaXMgbm90
IG15IGNvZGUgcmVsYXRlZC4NCm1ha2UgQ1JPU1NfQ09NUElMRT14ODZfNjQtYnVpbGRyb290LWxp
bnV4LW11c2wtIENIRUNLPSJzY3JpcHRzL2NvY2NpY2hlY2siIEM9MSBkcml2ZXJzL2RtYS9sZ20v
DQogIENBTEwgICAgc2NyaXB0cy9jaGVja3N5c2NhbGxzLnNoDQogIERFU0NFTkQgb2JqdG9vbA0K
ICBJTlNUQUxMIGxpYnN1YmNtZF9oZWFkZXJzDQogIENDICAgICAgZHJpdmVycy9kbWEvbGdtL2xn
bS1kbWEubw0KICBDSEVDSyAgIGRyaXZlcnMvZG1hL2xnbS9sZ20tZG1hLmMNCi4uLg0Kd2Fybmlu
ZzogbGluZSAxNDA6IHNob3VsZCBub29wX2xsc2VlayBiZSBhIG1ldGF2YXJpYWJsZT8NCndhcm5p
bmc6IGxpbmUgMjIyOiBzaG91bGQgbm9uc2Vla2FibGVfb3BlbiBiZSBhIG1ldGF2YXJpYWJsZT8N
Cndhcm5pbmc6IGxpbmUgMjg5OiBzaG91bGQgbm9uc2Vla2FibGVfb3BlbiBiZSBhIG1ldGF2YXJp
YWJsZT8NCndhcm5pbmc6IGxpbmUgMzM3OiBzaG91bGQgbm9uc2Vla2FibGVfb3BlbiBiZSBhIG1l
dGF2YXJpYWJsZT8NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZSBjb21tYW5kIG9yIHBhcmFt
ZXRlciBpcyBub3QgcHJvcGVybHkgc2V0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZaXhpbg0K

