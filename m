Return-Path: <dmaengine+bounces-4223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62434A22928
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 08:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650193A4CD2
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7871A8F7A;
	Thu, 30 Jan 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MgRCNLI+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E61A3BA1;
	Thu, 30 Jan 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222209; cv=fail; b=f/W4+XbX1P/K0UU4fxthpd5BhPwMSGLlCRVq+mIbASvR/+7civEb1UIw/3Aj30yUKp/P0I1Z4gIjcY/UqOGxfCcHqZp6iTh4X1SBDpmHvGA/6z55ptgVUXm/A9DnawolyUXyUjBbpL2+K6sOiIw+8WcnPrFKZx6jOrNCv9brc1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222209; c=relaxed/simple;
	bh=DP1xtMosPXo3BQC9WwZMChzWY+L0g6nrWGzx4zvaBg0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XL6Vl8ofVK4+xBc1/c65AxCpk1QEGhomQCJWewDeJZm9Dg+gHjoHdM4oUNeQsQh05fEbGrG2HHteQL2QPgsxK9j/7yiZXWBHaB8+srnuwv2eYL+s6gq/nI11hLdlvtJFi5Q2gK0gHKe7R++3r3jq49tzMEQykT5hjbaMVfjLBg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MgRCNLI+; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F76j32JgSXldodc/IpTO/vhm6To0gbZ8EtrW9j5AbxfNtstp/wlgqTcE6nV3jB9cJTs8+pe94apMuabE8se91NKZcjgZhOWlM+QZs+2uJ/IyzPOXRbPl+PfQeR23PiO/AfMqj+JM++CxnyThhT2DDBNpag164qJ25DgREhDDFgsdbBfZkow7x7Ddd+7Wbthe0LSH0xIbrrRtYCla7mAh3iHB8fmfRfHPr53oIh82gjF/K9AUrYzQVuT1AsG/S8gp5Egg0ENe/UIwjwfwSvfctQk4fkCU9yIWbWILvCHUVWs/piNlICIm51nxtb5JDDDrhKfoj8NsT+UJ49ZHKtGARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ujnOnkSfzFJ51SAOBi0KsIohJCclPwqboTH0vHAn50=;
 b=FlT0/ALo0MY10l4NPIWxR3WAm8B3ln2JGQzZ4c7yHk+TAlr+E9+KbMvDseE7IvkfK6YMqLOjPSrIkYlMw++urkBWQ4wBbj1bxjeEPW6d27iWIVCru75GU9HFSa2bZ/YsglrVrzRXHYG8I3Y1WzJgQzPLeyAZZWviQj7z+WEDVaHfp4sWIAwpSyODYb26+omUOBvwiUWViwh+ZIPYQWZfGa6O0CbzJJm9z+wxezjhqw+EeqqxEJKsj8izlpfYi6XP8Ypo1Bbg9gxfIHSdYTjU+YPjDP4iqVkkzG7OtxzXwF+YtVaCdHABVv6n7vHLwSMyvn6LP2dxT84AADNxcuoyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ujnOnkSfzFJ51SAOBi0KsIohJCclPwqboTH0vHAn50=;
 b=MgRCNLI+SNFb8JmAwtQcUXjpunLUEgMjh8Dq1G22mtD+lRy6fRLf3pLPHEHVj1w0A0NH33Qqi2eSYo1X6GC7RC4WB+3CUexb4OfPszr+rt2m4DTVGjIVjbusLMK0C80zMICd6JTVLCsdWcnWMp3mLtPLKv6q1YXO+3weBi2Yn6fCyVjlXY6fXwMwN82xPZmwZZ/blx4wr7PSlA+dBB/Gcn+JjueX5P+/2eGEsT41tPvb3PT1bPPKk/pm0NjsKKFNFRBiioKE5/QL0B0xTugWdlGgw9lHsscoKxGuJiwW/pM/VdRO8pDHD5xORihkwQ6VSK7VrQ67O3eX+s2wjLhGSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com (2603:10a6:102:26d::9)
 by AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 07:30:04 +0000
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515]) by PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515%6]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 07:30:04 +0000
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
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH] arm64: dts: s32g: add the eDMA nodes
Date: Thu, 30 Jan 2025 09:29:51 +0200
Message-ID: <20250130072951.373027-1-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PA4PR04MB9567.eurprd04.prod.outlook.com
 (2603:10a6:102:26d::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9567:EE_|AM9PR04MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f44163-6840-4bfe-4ae8-08dd40ffe9ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2xzZHFXU3YzRENlK3VZM2dyUXl3NWNxQzh5RVVJNHo4VG5GakR2NFVTRXZH?=
 =?utf-8?B?S0U3UnhWR1hWbzFSeWFzOTMvSk80MmpVT1h6c0ZsM0s3czlQWlhKd2hZTlM5?=
 =?utf-8?B?UDhtUUdDNlJwWGZEdmNFd1lUN2N5d3EwTDQwR1cwczRyTWUvNW5Qb1p3TkNM?=
 =?utf-8?B?Q2dQTGFTMkp3Nm1GV0JROSswUXlMNDB2ZlRRQ1BBNXl5aVNVUGh3K0NWNFZ3?=
 =?utf-8?B?VWFXeVkxSnQ0bWo4dFlBbTI5Y2xtT1FPWmxZWSs5TVBnOXhNcFFRb1RPS2tQ?=
 =?utf-8?B?QWZnNEovU3pQeCtKK0pvRW1ldmRxdXdtQzZQb0hFaWdiSS9YUkVHWHo0VUFs?=
 =?utf-8?B?WDBlek5Yb1RqQ3h3YTc1cVpuMUNnSm5wekQ0NHFtWXQ5anJQMmxoK2toVG9a?=
 =?utf-8?B?WmZ2K1lVcGJUNkpoNCtSYllwT2pIV1ZJSnR6M1FubTJnS2lpcEx6Z2RKK05n?=
 =?utf-8?B?bFRJUXBrOHhTMVYyY05zd2ZBbXVSNStnb0xSVmQxbWcvcmErbmZzTjQzc3dX?=
 =?utf-8?B?WHZnSExadzg5MnpjSVRRUXhQV2dodDQwbFFKWWZhdVh4ampKdUl3a3pXRi9a?=
 =?utf-8?B?U2JLa2pmNWYwTnM5aVVXRWNKY1V0a1VXUGszVlA5OUhUcUNnQWZ4NGdOUldX?=
 =?utf-8?B?dUdBbWVnbS9sQUw1bTArMWsyRExEZzNRK0haajlmallrbFRmc1N1S0lkTWNJ?=
 =?utf-8?B?T0NRMHRZVHlsTlYwQkQwZWxUYlk1N3RHcjQwaUcvOHM5Y0tkKys3MDJyME1P?=
 =?utf-8?B?TU83b09ORkJCcjdSdldjemYwQXhONmR2bHBONklDeEdtWUtJbFFyb3dubzB3?=
 =?utf-8?B?SDRrY0daYTZXaGZTSU8vQ3VVTUE0ZzBDVWFKSEZ1b2F4NWp0ZzZXem9uQU5O?=
 =?utf-8?B?WmZCUVNSNnZnaTZXbTZCcWNYMzBmcldWbVdYRkxwZU9YZmJmWEUwZUZ0K2pJ?=
 =?utf-8?B?ZzRnTjd1a1E0UlZETzIyRkgrY3Ztd20yalZOaGNzR0ZBZ0R5aFkzK2VvM1p5?=
 =?utf-8?B?T3RXMUo4RXoxK2NadFowNUV6WU9IVlFVUkVVNjBuM3g1OU1kVVVScG9oTVFv?=
 =?utf-8?B?UWwyMjNvQlcyQ2cyM0NZdEo3aDJoTGJBQ2xBYmxKNjlnY3hhRkIrTFZFY0FG?=
 =?utf-8?B?NUxUVHA5U0RRaEpqeERzbktkWExZN1JtVHM1a2JFTjJja1FLV3B2VzRtTERL?=
 =?utf-8?B?Nzh4aFI3TFdDSFVkVVNBTmZXR2hrT2hWT00xZHJvczV2Mm1razRsTkQxdkJk?=
 =?utf-8?B?dzBoWGNuSW1TQUFRNGtDa0UybDVlc0d2OGk2U1RodnR0UktwbWxudVN4R2Zo?=
 =?utf-8?B?a3orb2M0VTd4UEhMZmROc1BCL0tLMWJXeDBKNDkwQWlleWhIblIzVDdHWkUz?=
 =?utf-8?B?K0ZXVHd5OG1qY3BVa0hBdTJZVmk1c1ZKWm1mM2czM3B2M3pTQTlTM3FROHc4?=
 =?utf-8?B?NWZ4d0pGSzJVbmxLdGQxdUNsZzU3SGhRTDRGMHB0R01ONHhjL0wzZk1QTm5p?=
 =?utf-8?B?VGpQRjRNRTV3UURyem5TVVgrT0NKOFFMN2grSXdFQ25nMzA1blFIZUsrMmNJ?=
 =?utf-8?B?bS82dElUcXlwVFdwSkU3Sy96NXVJVGxDSDRaLzM1M1RHZytmRVB0V0hRZ25T?=
 =?utf-8?B?TUE0TDJjc2pYWFlCeXA4NjAxZkVRbGxDYVdvaW1pcGJCMlcrYlMzU09oNHNo?=
 =?utf-8?B?WFlBUXR1aTRPMk8rVmZnR1RSN25velRrZ21zREEyZGt1WktKM2FucmZRUkZX?=
 =?utf-8?B?QWhsRU15RVZhR2d3dURSRDZXUGNPbVhpUzFoaWlJUk1BeUNXSXNxRW9wTWJU?=
 =?utf-8?B?YndxTUZlNEpaVncxQXRPMlpXa00yQWMwNmFrYW1GQk9IS3U4YjRwT2ZkdzUv?=
 =?utf-8?Q?6TkfORtlvsTkV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWF6cnFaNlFJOFg3MTZ1NHBUUkd2SytsVHloa21zcGsvUDBpcEhVczFvRG41?=
 =?utf-8?B?RWEraU0vaE1aZHBuWkRvQ1J0MmlxRElxbVBXZnFpY3Q2ODdEUGVQZEt2alpn?=
 =?utf-8?B?K1ZyL2M0YjJhM3BndUR0SHVSRkNrbXNQbEVBN01EVE8vSm5GaXdlTXE1YlBH?=
 =?utf-8?B?SjJGOVE2cmFTckNiYmIyenFEeUc0bG42Y2pkMG8wbjI0SUhleE9VZHZZQjJM?=
 =?utf-8?B?bnhTcEdNMWlpNDFxM0FMS3dJSHI0dldEeDBSSURxQnBZUlBIeEtoVXNDdXVr?=
 =?utf-8?B?MjU0TVEvaUVOREp1MnhtcnZCVTB4TWM1c3NYMWpTbmRrMHc3ZThqdkxuRXhD?=
 =?utf-8?B?RWJta3RlNmFxVno5UlVUQXM1WkZ5MFRqSlFNY3lHb3VYMkJpWHc3R2JUT0N4?=
 =?utf-8?B?ak1PYjJ4STA5cWEzclFibFJad3ZlWVNzdllQbFF6TkZaTnoveHEzQlFwNzBp?=
 =?utf-8?B?UzJHZXhWdGg4YUt4OUpOS25CenkyZC9yN00zKzlySDFDMnQ5aXJPU25IdlRw?=
 =?utf-8?B?Skl3N1pXU1NweXpiWmFtU3FvR0pIWDF1VUVPWFowR0NoMDJmMmZGSzdORVNZ?=
 =?utf-8?B?dVBLdkJPV0lYWC9JcjVSS28vanNuUHVtWkhJc3FBU1pYNGJNSGFLRHE4YnBD?=
 =?utf-8?B?V2lDODRZcExPU0crMG1KU2RBeHU3czc2M2xWb25ydFh3TnphOWphZzV5UGVy?=
 =?utf-8?B?dVJnUi83K1ZzakE4M0xOdEVHbzJNQ0JLa3JJbjEyVzdyVkhVS0srZnI3V0tM?=
 =?utf-8?B?ZGhRL25ydUlGQVhSaU1RakhqR1g5SHgvckVyQjlmZXA2bFMrWnM3NnNEbmdD?=
 =?utf-8?B?eU82WEZINFBlTkpUL1hwdFI0VDkrNUpXVk1CY2Fib2ZyOHBidDRsTWlteUdE?=
 =?utf-8?B?YllManpDeWZkdVZuOUtrcmRQNk5YcEVPMlVlK05pL0FwQjI0MlB0d0tITEM4?=
 =?utf-8?B?cnBhNzhWWWlNbGF4YTF0UU9sckhBdG1UNURFVkU4NVlzNGQ1djM1L1B2ZGNp?=
 =?utf-8?B?dW1YSlVaalp2Zzc1dGNFN1hva2IzRDJ2ek42SEhhTVoxSmVNRDBvSndzbVpN?=
 =?utf-8?B?ZWdyQ2xoanZod1Q4TUlvWHVBMlhxK09DbzQvdzBoZDJNMFJtQ05ENnBWZmZL?=
 =?utf-8?B?NHpVa0lKcUtwRFlTY2RFdHVaMUZITDhnNjZwSys4WFRaQjNsSFZSbTd4Zkxx?=
 =?utf-8?B?MDFIeXNWU3dhbk1oREV5ZXlISGlqdzFrWWhKSlYzTkJ0S2JOUmNLZ1lOUUUz?=
 =?utf-8?B?SE1waTBXZCt0elplWm4rUU9wRFB0L1BDbGxhcG9aU2s0UVJzSmkvUDZmL1FE?=
 =?utf-8?B?ZUxUWS9JS0tLaXM1VnJnU2hNZTZqdnFHTm1tRDRObU1HWWtkN0FwQ2JkQ3ZP?=
 =?utf-8?B?WFpOT1B3VVJEeVVkYnlkS29rWHY3YjJpcHRoSGtoTUwwc1daZ2hGM3hpS2ZU?=
 =?utf-8?B?dkp2ZTVyS3l1L2dUMjBQUnd4U2tGRW53VEhVaUNPSGwwcmNQQXRGUm9FRHVk?=
 =?utf-8?B?S1FIclpqNTg3Q2MwVXBncHQ4MmUyN2NhNGRld2NkdEk4KzRCRkJKWncvY3Vn?=
 =?utf-8?B?YU5kV0lxa2RMQ2JqcW5sUEdaeTBLWkRMajF5WU9Vb2pKZVppdDFFdGZRcmRE?=
 =?utf-8?B?a2xJbEtWVC9kbHlLU2lJSXNNVkd4N25hcW1qQnVWeUVObUVUOUFrMkhXOWlZ?=
 =?utf-8?B?N1lkY090d0s3RjcvR21oTjZvS1dBRWJFSlBwWXBHNWduMDEzdmtKNkwxZDYv?=
 =?utf-8?B?MWhhT2hWdjZyNDFxRUNkbE56eGVFbjl6cUZURzB4SDRoc0doRlN1eHpObEhR?=
 =?utf-8?B?dzRRQnMyblRmcDZHM0JmWDVvb3B4cEF3L0FtVnVlVTJoQlNxaDBEbFZKRHV6?=
 =?utf-8?B?Qis4NXpxa25ZRUJUdmVQbThkZzZDSnhScDVvUWMrVmpGd0Jjd3N0TURzNmZL?=
 =?utf-8?B?Y3RQWFZzZ2N3OFp6WDdOSGhzYVoxc2dqTkJ4ZnFMRWpmMkV0SDVHT3ZGUlA5?=
 =?utf-8?B?S0VlSGoxQS8yNHEycXFoM3g5TmFsbm5DdWxhd0xmM0txWTRTWEx0QWQ3ZElz?=
 =?utf-8?B?TkJwSUxPUDc0ckhTWWovTjJZdDZSNFRzU0hKRFM1T0MrL1c5YjV6WHFPNkUx?=
 =?utf-8?Q?0FL6uYdJcy81NEXYfFAsS87yE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f44163-6840-4bfe-4ae8-08dd40ffe9ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:30:04.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ib339OD4LoEwqRhFu3Ao0/hPXEdvAFCYel0KpH5WKtLnwbbRAclyetvfdSUzBeZNIHLrfLBO9BovkaIAJp/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8487

Add the two eDMA nodes in the device tree in order to enable the probing
of the S32G2/S32G3 eDMA driver.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 34 ++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 34 ++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 7be430b78c83..f73cd5a0906d 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -317,6 +317,23 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		edma0: dma-controller@40144000 {
+			#dma-cells = <2>;
+			compatible = "nxp,s32g2-edma";
+			reg = <0x40144000 0x24000>,
+			      <0x4012c000 0x3000>,
+			      <0x40130000 0x3000>;
+			dma-channels = <32>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx-0-15",
+					  "tx-16-31",
+					  "err";
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clks 63>, <&clks 64>;
+		};
+
 		uart0: serial@401c8000 {
 			compatible = "nxp,s32g2-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -333,6 +350,23 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		edma1: dma-controller@40244000 {
+			#dma-cells = <2>;
+			compatible = "nxp,s32g2-edma";
+			reg = <0x40244000 0x24000>,
+			      <0x4022c000 0x3000>,
+			      <0x40230000 0x3000>;
+			dma-channels = <32>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx-0-15",
+					  "tx-16-31",
+					  "err";
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clks 63>, <&clks 64>;
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g2-linflexuart",
 				     "fsl,s32v234-linflexuart";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 6c572ffe37ca..ca8b50196ceb 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -374,6 +374,23 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		edma0: dma-controller@40144000 {
+			#dma-cells = <2>;
+			compatible = "nxp,s32g3-edma", "nxp,s32g2-edma";
+			reg = <0x40144000 0x24000>,
+			      <0x4012c000 0x3000>,
+			      <0x40130000 0x3000>;
+			dma-channels = <32>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx-0-15",
+					  "tx-16-31",
+					  "err";
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clks 63>, <&clks 64>;
+		};
+
 		uart0: serial@401c8000 {
 			compatible = "nxp,s32g3-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -390,6 +407,23 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		edma1: dma-controller@40244000 {
+			#dma-cells = <2>;
+			compatible = "nxp,s32g3-edma", "nxp,s32g2-edma";
+			reg = <0x40244000 0x24000>,
+			      <0x4022c000 0x3000>,
+			      <0x40230000 0x3000>;
+			dma-channels = <32>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx-0-15",
+					  "tx-16-31",
+					  "err";
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clks 63>, <&clks 64>;
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g3-linflexuart",
 				     "fsl,s32v234-linflexuart";
-- 
2.47.0


