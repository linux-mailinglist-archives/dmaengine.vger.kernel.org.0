Return-Path: <dmaengine+bounces-4041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2509F7988
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A089716B6BF
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351A223715;
	Thu, 19 Dec 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M4q4XFHG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F12236E8;
	Thu, 19 Dec 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603891; cv=fail; b=P3FOBiG7nCEwQlI6a/b/5F1fbk+BScfOEzHm0gVEYoMyKJSMYM84oqKoR4XTgTfYoktMav2qFmmdBMYGNFIvIF5kU9q84la8GZo4aB/Rg+ZGYWbA5f5xYcxpCae2LVdJZzTxuFT7AhhgFiv+i8RH26ceNFzoThRibuMTG3exNKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603891; c=relaxed/simple;
	bh=HmGCBiXoSrLxJwMM4N4YHRHB1wg19cbqt0DXJEaz1TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy7Coy8i2lUojIMUOTs0ubIVZakgJPoKfY4r44CVMWKPI77xsPeM9We1CM4IY1J00BqyL6v692Qjqi/35UNkQ+i2FQtZU1Ic4tfeLpJmM4YGQNHzPo1+sGbNAXncyJBGHCys6yni6b3tiTt3oPkG9Y1nCi0Py9zzSZ85kLqJszA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M4q4XFHG; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEaAeeLyYRmOkZDADYXXDLacjBFELzIxnM46zMULprRV1cZQw2A3Kak5XSJJhM8MIH5R2RLNCqJ0JFHON+CjNQ0KsGnvJZZri0Z0XAzHaGLTIOgfav7XDOw43/yaIEpk+Pr5DlIad8YRjav+F/QrKA9Rr/fErEBGqaS29u3PqtoIinnBimmLvRWJ8eO6Wv58wAXa+hz5Rjd4IOzHjxc2ZdMkASeAyIsrRmUnmLEqv4PBJQRwjFnbQ6JX7zx79EKCmZatuQ1eHp+kONv+RDVg3F/N2b7sF+69j5brCBQBiw5LZrR1+CYiq0mxzKJS3erILMx/KbLDd/KWyKNDysRgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc/TtVZP9h6Q5W2GpYNktrmwxyrCTzOZfm5JA7UiZkg=;
 b=oySR8y2YhS4vVGwN/IDWsyGEWS1rCWIxxjuYYkbHaj59yytu5/aH4s1xOzLsC9K90JmqeramnAHCQVvnqEeQ2js8WPLyblQ0D0jfIaaj1oVso80+JvmqlALOk3rQcttcLNF2pvtLHrvnGXdG7QXLMcfE6kIsnaQHWM+TpZWbBJCvJc97DxNsHZ0SwAPXG66w+z6BGCWf0Rg5S6gKMOd1NTMViSy9//BKNEnHgmPnTlIGWOzBwsZl9NOXVUC0099KqN3AQ4+6uzUoKFcxyQN1UkMr2ENOYpWGtVz/BwCslophZl3Wh48FD6uU9oyLYpWSVzWgg2XHNrujLxrNwMfzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc/TtVZP9h6Q5W2GpYNktrmwxyrCTzOZfm5JA7UiZkg=;
 b=M4q4XFHG3ns2aEKmw1kRl++R6YGtEArRRKslOaXuIT+t/OU1F+vE/e1/0aY+G9GwReFQFNvS4H1pTe38PtrPqbq6KWtWPKlgC1Kzt6FzJsmWQnQ/gXcPUo04UGNb1r/4eJYCX6JKiSkaKKkbFKx5v9EYuCH5qH70p4fm1Vbq4LpRmN0R3ZghEA7hQcleFDdWrxIY/Zkp5D/CNBG/pFsjtRysmhuAPqFIvxWQZkaik3L04fSpwqfDFBzXPR8Bq5sXGwlb0b5yLhyvTH8U3dlrrcIdG5rF8jpCP/Tp1St/haNy+a8e8QRz4H8WCFEncPKWB+k+zslbi+LjR7sOmDR41w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:45 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:45 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Subject: [PATCH v3 4/5] dmaengine: fsl-edma: add support for S32G based platforms
Date: Thu, 19 Dec 2024 12:24:13 +0200
Message-ID: <20241219102415.1208328-5-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:208:55::17) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d9ddab-7e76-484c-5b78-08dd20175be9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVdXcWEyVkt3cEVSemdnb2hOUi9wWk9ZMzJCWmNibmRoZmNtaHkzWEZnUzg1?=
 =?utf-8?B?WkdxclVMVTBHTDA2UHVPLzBFQ0FuSWFoTjVHNWRiZWlpQVhWcTQrU1JyM1Vt?=
 =?utf-8?B?Q0l4UDhjalhpdWJ6d3JaWjhDeENwRkVEWGpiQnhDL2lYOTlHTlVmYzVPTEFZ?=
 =?utf-8?B?MHNPRis2SDB6TFBibkJJUVlJeVh6UVZoMks0N3R1Y3RBNHJ3WHV6ZFYydGRw?=
 =?utf-8?B?NWRvUDJMS212cEJIK21QZlJlclpTMjFpclE5dWpGK3BVVkVmQ2tUTXBFbHlv?=
 =?utf-8?B?YUJjV3UzR1Bmc0RsNG9KOTl5RlNSM0pXWWJVd3I1cHZia3g4aCtYaUdyUXJO?=
 =?utf-8?B?ek1aY0tocXJwSEFhRk42U0QwVVROQUIydkpHdFQ5Rm5lS1UvQmNONGRlUkhh?=
 =?utf-8?B?NE04L0J5TUpVQ0Q2aVdpRWZ6RGpuR2krYmJ2ZXZDeXZqQ1VGQ0RhejExaUdw?=
 =?utf-8?B?NVdNUDVuV2Q2Um5DSTFXMDRRV1BDTzZSa1d6di93M2N2aTUrNENYemRCRFNt?=
 =?utf-8?B?MWwxbTFoUlVJWWZaaTlSMllEdlROLzkva3Y1K0dRSFEzeG9TTDRzcE83V1Bu?=
 =?utf-8?B?UUNtRUkvMUN2R09hcVlZdi9peW1IL3lpd2FXZDRRMktzcS9Jam5RZytzY1R0?=
 =?utf-8?B?SThnb09Xc0h4bzlIT2s5WTdIVzBFcERpVUN3UGdwUVFrb2s4MytlRDE5RkZ3?=
 =?utf-8?B?ZUl2a1Q4OVBYckJoMUxFb1R3cktHVmFpd3hOTmh0RUt5VFVPTW1wMVFQeUJj?=
 =?utf-8?B?all0S1FqNWZqQ3pCZ2FVN2FEK0MzWVFxd253bU42Q0tCRE1hL1BPQ0xNZFU0?=
 =?utf-8?B?Nmt1QTZ5N3k4VkY4WEh3NkM5ZjN6OFVLckRBblpWV1UxTWFReFFyOElkWDRj?=
 =?utf-8?B?bVFHQk9nL1IzbzJsblpWUTZQRE94L1RWSzZPVUwvTVNEKytjNTJ5UnhlejMv?=
 =?utf-8?B?UkJtcGVzZXlwUVFYOU5EeHdpK1pPZVFEVys5WkRTOGxKamU5YjJrTDF2SFEz?=
 =?utf-8?B?VHd2MzgyL3NOMEQxQ3ROaThjN0U3VTNwbkdYS2kxNWtHREduaEp2WlNkTmFZ?=
 =?utf-8?B?ekl2MkM0emlQdHlPbHcrZG9nbTZTYTJJKzh5Q2VOWU9yWndROThQUmhsekpP?=
 =?utf-8?B?bTBGNzU5dzdXVlJQVElnekJBZXBCbitGbGRaTkExMytBSVZjZkVyNzlYS2RP?=
 =?utf-8?B?dXNhd204OXR4Y2hidFEwNncyMkJqWkNpR2R6OGJDS2xBclcxZ1c3c1BRM0Yx?=
 =?utf-8?B?OTI1a0kwSFdKTzZ4SlRPYmRVWDZvNEV0S0JnMGZhWmRJOFBXZnRFTFJlYUlk?=
 =?utf-8?B?RFpuMFBWNFlHczV4RFdXdDZhQXRoS3o5RzJIQ0NKdmhHVlNGenQ4QUhuQ00z?=
 =?utf-8?B?YTJ5ZVpYS1ZsVWZYamFDOVU2VytNdEQ4blllN0dvRlpTVUFPSDJuQ25mYk1L?=
 =?utf-8?B?dGtWZGlhL1hWUGlrMk1qdkVpeTZHM1lQSUZ5aHhLNjZLcUN3Rnd0aVZJK25O?=
 =?utf-8?B?bmJQcmJLWnNlQWZDV0tDK09hMHhNZGJDd1V3RGNNS3UweUJES1Z2bmFJbVk5?=
 =?utf-8?B?MWFJK2lFSFladmVNQndUeVM4cHY1bzdKazIzTVZ1ZFdwd0Z1MEJnT0RBeGNX?=
 =?utf-8?B?cDIvbmFKM1dWMXQzQzdBSUMzTXBjKzJCVEo3ZjRuSW5lbjZuZmpVNVhoREFv?=
 =?utf-8?B?K0FvZVdIVUZiSkZ0bHE4R0Z5alJzWGpYeGNuWTl2YzdnQlVsRjhNbWI2NGZ0?=
 =?utf-8?B?ZWUrNktrNi9CbldaZ0hna01oK1VwT3puZWxZQ2Zoc0ZzeTFGeVltSGtKYnl0?=
 =?utf-8?B?WVZ2RmRwTXRxczA1RVBVUktkVzl4dGZqYkdHbGxkTEZCYXE0KzZZbjhzN0tJ?=
 =?utf-8?Q?M/E4mIG4640LV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllHcjBya1hDZnF4YjJMUmwvUXNHdmEvNlNVbEd2V3FnTHhQeEZxdWxXVWlH?=
 =?utf-8?B?cWxGaFhpYVIzaG5rc2xVKzV5UXB1MmlCbkhzclpyY3ZDK2Z5bTVoeDRjY1Q0?=
 =?utf-8?B?a3lDSTdNSUJyaGRQY2NoTmE5T0NXQkkwQW5HVTNjLytRVHFseHNjUG9TcmxT?=
 =?utf-8?B?bXRseEtjd1dGZ2wrUjhJSVhXV00zR0x4amZRamFlbWR5OFROeVFWMi9pOTA1?=
 =?utf-8?B?ZDhNVjN4ZmU1dnNiLzVheGZHK3l4bVo4M3JFWTJEQjdWWlR6T241eXFvd0dI?=
 =?utf-8?B?eTcvblBSbUtaTmIxSVlyZnFhaFI0SThkSE1OV3Q5RnZLUzA4ZFVxTi94ckgz?=
 =?utf-8?B?WDhHVjRtcDBTSHI3WjBtc2NtNTFiREJLWXVlRFkzYTd0MFNFekFTYTZBUWk4?=
 =?utf-8?B?NS9zMXlJMk5VeE1HOGdsZkZrVjJwbTN5S3hoTytEVGZ5Ly9xTmxLWmo3ZlBO?=
 =?utf-8?B?Smp1UGt6VitvRm5pcjloSzFaUEd1d2hLdzdLRlgrczJUbXN1ZVlUdzBFdjhR?=
 =?utf-8?B?V3NRRGNYWnVyczhqVzBYek9rRGJyV0ZuSmlPWmJUTlBQUk5zSFZNMTNXb1hP?=
 =?utf-8?B?Vk1qbUNxUGFNVGpTZ0poL0cvNGg1clFWcnBMZTJmVWdlSWFDK3ZScGdkVWQy?=
 =?utf-8?B?ekVrSUdydm9GdGpZcitXa2VqVHZDRFpDbGtzMzh0UUwxbXNheEN6TCs4ayth?=
 =?utf-8?B?UENmWUJvajh3RU53Mkg3NEZNRVBUOGJhSDgvc0Z5WVJkZTF6blBydzllaThr?=
 =?utf-8?B?TkNIVlRYYm80SEg4SThOYVBKYlVnK0ppb3pxYmxQNW1vNklVQWwvbDMxS2RC?=
 =?utf-8?B?ZmZJOFVnMVB5Y0svNUphNy9ndjl0UzBpL1l5TVpZZHR6N2tXbUN1OTV4SWNM?=
 =?utf-8?B?T3pJNUw3eVpHV0R1M0c3Ry90emh6N3R3VTBIZ2ZpR01yekt2N0RxTDd4VWEz?=
 =?utf-8?B?OWFYTUtFak0yVTBEOXpya1VTNjhXR0x2a2lOb0R5cDQzSUVqaXJrVFd5Qm50?=
 =?utf-8?B?UkdPTWZkOFFZeXhEcUxhem5CdkZFb2ZMVjBtUThaUURLQ050SEZTM0tnWVho?=
 =?utf-8?B?TUNueHljZjFreHFINTcycWptcVVIUG1SaVJEZWs0WjlvY0FNY1lxdUhBYnhB?=
 =?utf-8?B?TVVoS3VuUk9CMU9mSkxQVTFOSkVJa0kzOGg3WDJSNmJRZThkWDk3bi9jckUw?=
 =?utf-8?B?TG41d0czcUdhK21QbmtWOGRFdFN0dFFZZzZKTk5LZ2FCc05rZzg3TGZRcG5X?=
 =?utf-8?B?SUJkV1VkcmxSbXM4TmlJb0NPZVg1YitvT2dXV2FHTm1VWjA3OHMvbzhzQWlZ?=
 =?utf-8?B?Yis3b3dQNU1kZHJLOGgrbGd5VDJqdkxkVnhtV1VqWllUb0J4RkdaRXQ1RElm?=
 =?utf-8?B?a2RRTzVGSGQ2cGo3K0hwemgzbnByM0plRVBnUkJQRWRkK3Z2VDVFWjVIZk9V?=
 =?utf-8?B?UzNXMHNxYTdVMHROc2h0NmJWZ1FZN2k3M2J5Y1ZRV1pESDVHamsremtNYWI0?=
 =?utf-8?B?SytwUTdvVEhrbmVQNkl2N3lsZUR1bkl1YjVTdTg4UHVUU2UyM3ZRS0grQUUr?=
 =?utf-8?B?MlRDQklublUvQlhhZzFrRnhzV1AwSWdUdnhKUVR4cUczR1RGSmxpS1dWRTcw?=
 =?utf-8?B?dzRSVWJ5NThDYjkxRzRwbWVPZndHSkFuZHczTDRNOXdVV0lDQ0RzcW4yZzNu?=
 =?utf-8?B?cTFYckNmTmZmWjd3cWhQdGRpZks1azc4TW5XVEZsMzJpeTkxUmx6d1ErNWZ0?=
 =?utf-8?B?MUJhOTluUWk5RW0rc1MzT3NiQW8wSldxN0JybTJNNkVzQnFEVzdRMHhsdnBO?=
 =?utf-8?B?dmFXc2p1aG95S3A5TEhkS2NVVDhuK05sVTNJQ3lrbmhSQTBEUEpvY2R6UThn?=
 =?utf-8?B?UjFMOWxEZEtqYmRNUkRVRG12QzdzRGV6MVBHNGxFM1ZCeHZHR084cHFXRitS?=
 =?utf-8?B?b3g5VWNjQnhmcWYyd0JOb25RRG9Jb2s4TG44UXBrU0lrdGdSeEw4V0JSaXly?=
 =?utf-8?B?MERUcUlmcUxLaHByVUk3Q0NtcFBRTjA0UStQdUhxRlYyRkZoNjIyRG5pWEc4?=
 =?utf-8?B?N211OTAzTmdqckZjVjVVUUdITXRKRDU3RER6Zzl0R096aHJWMStKMFlsYytT?=
 =?utf-8?Q?aeDGhEXf0W0rbUbkAtABOSM7W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d9ddab-7e76-484c-5b78-08dd20175be9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:45.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4/DGw5ME13dXBR4/SRM0HkmnP0nLFmWSyGTe78ggMhVIv/dGBp9C1/Uon0SJQQpy5uAOCSkRHw7HPLIxv+ITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with two DMAMUX blocks.

Another particularity of these SoCs is that the interrupts are shared
between channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h |   3 +
 drivers/dma/fsl-edma-main.c   | 109 +++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ce37e1ee9c46..707fea4139b6 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -68,6 +68,8 @@
 #define EDMA_V3_CH_CSR_EEI         BIT(2)
 #define EDMA_V3_CH_CSR_DONE        BIT(30)
 #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
+#define EDMA_V3_CH_ES_ERR          BIT(31)
+#define EDMA_V3_MP_ES_VLD          BIT(31)
 
 enum fsl_edma_pm_state {
 	RUNNING = 0,
@@ -240,6 +242,7 @@ struct fsl_edma_engine {
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
 	int			txirq;
+	int			txirq_16_31;
 	int			errirq;
 	bool			big_endian;
 	struct edma_regs	regs;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 9873cce00c68..c9e3252d0da0 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -3,10 +3,11 @@
  * drivers/dma/fsl-edma.c
  *
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ * Copyright 2024 NXP
  *
  * Driver for the Freescale eDMA engine with flexible channel multiplexing
  * capability for DMA request sources. The eDMA block can be found on some
- * Vybrid and Layerscape SoCs.
+ * Vybrid, Layerscape and S32G SoCs.
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
@@ -72,6 +73,60 @@ static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
 	return fsl_edma_tx_handler(irq, fsl_chan->edma);
 }
 
+static irqreturn_t fsl_edma3_or_tx_handler(int irq, void *dev_id,
+					   u8 start, u8 end)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct fsl_edma_chan *chan;
+	int i;
+
+	end = min(end, fsl_edma->n_chans);
+
+	for (i = start; i < end; i++) {
+		chan = &fsl_edma->chans[i];
+
+		fsl_edma3_tx_handler(irq, chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsl_edma3_tx_0_15_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 0, 16);
+}
+
+static irqreturn_t fsl_edma3_tx_16_31_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 16, 32);
+}
+
+static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct edma_regs *regs = &fsl_edma->regs;
+	unsigned int err, ch, ch_es;
+	struct fsl_edma_chan *chan;
+
+	err = edma_readl(fsl_edma, regs->es);
+	if (!(err & EDMA_V3_MP_ES_VLD))
+		return IRQ_NONE;
+
+	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		chan = &fsl_edma->chans[ch];
+
+		ch_es = edma_readl_chreg(chan, ch_es);
+		if (!(ch_es & EDMA_V3_CH_ES_ERR))
+			continue;
+
+		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
+		fsl_edma_disable_request(chan);
+		fsl_edma->chans[ch].status = DMA_ERROR;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -274,6 +329,49 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 	return 0;
 }
 
+static int fsl_edma3_or_irq_init(struct platform_device *pdev,
+				 struct fsl_edma_engine *fsl_edma)
+{
+	int ret;
+
+	fsl_edma->txirq = platform_get_irq_byname(pdev, "tx-0-15");
+	if (fsl_edma->txirq < 0)
+		return fsl_edma->txirq;
+
+	fsl_edma->txirq_16_31 = platform_get_irq_byname(pdev, "tx-16-31");
+	if (fsl_edma->txirq_16_31 < 0)
+		return fsl_edma->txirq_16_31;
+
+	fsl_edma->errirq = platform_get_irq_byname(pdev, "err");
+	if (fsl_edma->errirq < 0)
+		return fsl_edma->errirq;
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
+			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+			       "Can't register eDMA tx0_15 IRQ.\n");
+
+	if (fsl_edma->n_chans > 16) {
+		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
+				       fsl_edma3_tx_16_31_handler, 0,
+				       "eDMA tx16_31", fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					"Can't register eDMA tx16_31 IRQ.\n");
+	}
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
+			       fsl_edma3_or_err_handler, 0, "eDMA err",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register eDMA err IRQ.\n");
+
+	return 0;
+}
+
 static int
 fsl_edma2_irq_init(struct platform_device *pdev,
 		   struct fsl_edma_engine *fsl_edma)
@@ -404,6 +502,14 @@ static struct fsl_edma_drvdata imx95_data5 = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static const struct fsl_edma_drvdata s32g2_data = {
+	.dmamuxs = DMAMUX_NR,
+	.chreg_space_sz = EDMA_TCD,
+	.chreg_off = 0x4000,
+	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MUX_SWAP,
+	.setup_irq = fsl_edma3_or_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
@@ -413,6 +519,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
+	{ .compatible = "nxp,s32g2-edma", .data = &s32g2_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
-- 
2.47.0


