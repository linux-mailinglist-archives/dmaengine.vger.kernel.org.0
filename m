Return-Path: <dmaengine+bounces-8569-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF+BLD5Remnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8569-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB7A78C1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E3BB3051E7E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7537883C;
	Wed, 28 Jan 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZZpw79Qx"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177A2505AA;
	Wed, 28 Jan 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623574; cv=fail; b=BktEZBwZ/JrPHCBu+mjE2QpFlCPCmje9Bpz8dc/MK+AoA/u72F48wr9Xb/LemtTqmbI0INwGCgpr0o/Xh3sRPs6hCZ8M1NE5zRHOGpnSWzSplSF9uHl8ZrQ0uIdXA98EkloP5JSOFLcW/yv8UAjsribeELpXbh5JcbdUrr0THs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623574; c=relaxed/simple;
	bh=B//VtRpbnVQ9Fa8FZBs2BPofG1vFvX55RuurZBgEVxw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l1nVWKeI9eunXJrw77YnxvYuBnKmxqBLJrVbIizfaT8xTkAtlxPWtF64VLCvU9OmyzHIOKnVGAiFBzpqP/PTNq0Sd54xs/H6TmiNsSghNGdxubSQbUkHDAhmg+E0rtHxKXtsqLFm0p9RW1a5ALsQ/D6FwaESZhCKHuJwocPDbaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZZpw79Qx; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcARq8dfPNd7jyZxAuv+CwzawyhOnuy9NYPaFCJDkvBZ4IwADOpj9HZO9QoR9jKr8Ac+dzu0yD3/K/bKV78JbZx7mOQ0udKuu7+RkxJVLy3QFOX09qEKrAjMQ2ts/bT6JS2neM94BKX7k9ihPX+WuHq1+VrK65MZtOtubg/ly5Bo9ObOgLbqJNXATVIsM1gBgYjiGRGNan18DlQLILFah89x4pTznInEOQ8QPZSZTKKgTjDuoMn0YHwG+kFpJLBoin+eBqM2KcZHhshwSkiGEKnyVKDVYeZEgeu4aM0SIAjTpeC3PQlfhabu83qYxB2PTRIxq5Mn7KUAs/QPMocKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19pzVHhE1/+6ys28wk7jJb5TKQ/OjbDAmyRMaWqfq94=;
 b=x5fwbVLk3iIDsS7ULnDHM55D0LPxJkvCVVGZPqPIbiFXLL7KMsnJmycTb2lgQnnOQ7aY4xQkKEEHR8PCONmpcld320macW08T8aXDrwn9r3xSOygsKBodmCn3HuqMjlO8EPr2je/XcS1YZ4fzUaSeeAuQIAazIFXL55i2VQ8LyP5Y50W1pxyd1S7fV5OuLvfZm3ld9+ax3fXpYe9jPo1aims82oq41jY7vhZ1/or8M6MMQ84olmRH9mO2cubDlGJIhwB+0DMygCOBB6nocnmIBIISIYq+MmVvYmIw3PHwIn4N5e3wmZFnaDjWpT0rjt0vegBig1TUm0Xz5Xs7qTBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19pzVHhE1/+6ys28wk7jJb5TKQ/OjbDAmyRMaWqfq94=;
 b=ZZpw79QxHtKycl3Sy5COGCXquUsGHjbk8Qx8TYPI4uNMt4Nc7a0yy1XOocpPTAGT5aieLOGD0+e2e5M/fxk2xj+HBhQZlBVWhoYGDKKjIEjsQEGa7khDbf//2Z8vCzZYRBhsBn4MdYwBy9QVUeGdGrD+ue5waHoEfgJZumN+ANQCsIha8XSnOc0ROwDYfUt4S4PIYfg9EsWbet5CeR4+EBz2JJQMA7nAlrSwh71BQlPKI3XIvDWmj0/iT/zPEiuw+ID1R/PbhPK9PyamR4S5AgMTdSz5fstMac4XzC7HcacbiAQeWbJQGd39yA9YO+6IeXhqPLvG2pjEMl7EsZ1C2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:06:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:06:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:30 -0500
Subject: [PATCH RFC 11/12] dmaengine: fsl-edma: use local soff/doff
 variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-11-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=1773;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=B//VtRpbnVQ9Fa8FZBs2BPofG1vFvX55RuurZBgEVxw=;
 b=lqykXi1QrcGXfdEx7JFn4kZy9caLGzqM+fjBHgv1avh2G1V+FJGNBZqGBG3XPfL9pbeereSMZ
 b5h/zy7dxlnC3qorJTqKhbnDUJUm8LL92Yfn6szzbDgcWktJA52VmVI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e17065-8d52-4de9-cd51-08de5e97e773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXhnd0RWNU9YcXFwOENMSkhDNEZLRUI3dW1NbWU2WkR6czFHakNTTE8xRUpm?=
 =?utf-8?B?R1o1Z3Z2WlYwMHRiZEkxWnVoY2EwVVZFOWhCN0t3U3l0NE1MclhyZm1Ocmw2?=
 =?utf-8?B?b0pjRWJFWWx3UjZvVkVNRnZkK2kvaytpdTlyRlRTWG9KRWtucnZ5NFBqZFhl?=
 =?utf-8?B?aEhjSk41OVdRbDZsSFNPZzlwQWxINDZuRzFtZGhvM3YycHNiY29COURGa2NQ?=
 =?utf-8?B?ZmZySmwxRTBlbFhuNy9BMGdPMnJSSU9GY1FOaS9aRGtSTDU4aDJuQVJ0aElt?=
 =?utf-8?B?TzErRXJsVlM0K01zWTVnQzJaZExmakpmajNoMUFZUGVaSVVzM1QxZTNCc2gv?=
 =?utf-8?B?WGdvNnQxS0RuZ1htdGJNNnZuZWZnMXpyMHlwbXhWN3M2QmdIanduWTdtV1pz?=
 =?utf-8?B?QjdJY1BSVi9MWTZRTVRFb0lpRG9uZnQ4cERuN1k1Q0xUa1BBcUdPcFJlcWtr?=
 =?utf-8?B?REh2K1lTTG5CbE43QWU3Y0hNOVVUbVQwZXhweFJzK0tNWW5Ock1BOURXZWxz?=
 =?utf-8?B?VUZkMFlRTUFmaEd1R01KOXJ0Tzk3eFloYkpYS1lrcUoyQVN6dyt1N1pHY1d2?=
 =?utf-8?B?SEtrZkpZM1V0dHBuYjd5M1FYbGt0dUprSTkyZWFyVStUZjg5em9wL2FyZ2FR?=
 =?utf-8?B?YkM2UDYxNlMzY05uTjEvNlRjK1pUbmh2VDk2Mk1LemZybUJsbHRFU3VCTTdF?=
 =?utf-8?B?cUhORmpvbmNxT0JrY3R2NWFBRTFienVuOVRHcnJlcjBlVng1alhPbmJDL09I?=
 =?utf-8?B?OHg0ZXNVRHZSU2RlOHJmclNjbEVPUUZpb0JTbVNQM1Bnc0tmMEZFTEZHQi9q?=
 =?utf-8?B?ZVduYjlSRmI2Q1UrV2RJRXptZEVrSS84NXN1NmgzOHF0MWdDd3dBbzRhSVRz?=
 =?utf-8?B?dUpBY0VxdmY2cVgyVldBMXdqQXc1MkFJK1JCUjFDcXJuT0dVL3JrbTdlMnQr?=
 =?utf-8?B?Y2YxQjNydjJHby9DOXhHcVo5VUNpM2V0bEJoN3dMYTY5NzZSTmc2ZVZnbzRF?=
 =?utf-8?B?Zmp2T0x1ejJ0Z05DWFEwaCtWbzAzUjBDRW5XTWNCWEx3WHlFZFJNNGY3QVhZ?=
 =?utf-8?B?THVwa0cvTjVtTksvSTFDUjZmeVdJZ3J6bWxYc0ZkcDk5MnpuYzdiN2xjM3NE?=
 =?utf-8?B?emR6elZ0cnBsSVdJNjlWdXBYNUJMVExvK2h0bURNdmx0K21JME95NzVobVF4?=
 =?utf-8?B?YzRMUS9aYkdvUU5iN0NhbW1IYUYrQ2E3eFRtQ0dyUlBzdnNsZmFJWktGQzlG?=
 =?utf-8?B?ODJsa05uQ1cyQmM4M1dqNTBKTStoOTJVdFlGNWlRaHBVa2ttbDZNQjhPcDV6?=
 =?utf-8?B?UlhTdmZuRFgyTUc1UXk4Q3VrQ0kzUkt3MURWVHFXVEFUcEQvTFdSV05xbXZM?=
 =?utf-8?B?ZUFoVWhGREtWN09JNW9rVkhTQ2pzRjJLUlVlMjVsTEN1K3BHQXNxYjN2TFFU?=
 =?utf-8?B?dWlVZnc4SU54cGdsSFVzTFBhcVVoRVF6MmplKzA2cFhvTjNyaDlCZnFTa29l?=
 =?utf-8?B?OWtxYktGUEF1bHNxNzlnL2VGbS9CS25ReFVwc21YYkJ4eVFIdk81NmZSQzJU?=
 =?utf-8?B?UlpEbGN1aTRHY255UE5sWjRuWWlyVDNTU3pRUzZVTTRUNmtjNWJ3bDBmR2Vv?=
 =?utf-8?B?cUN2N0hkN1FyMnhxM0pxYStNL29DWXY2L1dTSVFuQnFWdjhiMjhFZlRsZzRt?=
 =?utf-8?B?a0ZJc0ZWS1RkdHQydXBkNW84Q0Q2R09KbUxuSWt5SVJiNWR0ajVTN0VkYmJz?=
 =?utf-8?B?K3l3YjdWeG83bTBtMjZ5YXNSUzZSTmdnZk5aVmdpUGpYZDd0M3lDcmU0NUY0?=
 =?utf-8?B?OXErWGF1d0JIVmZxWmpLTk5XdjdLRTVxNG5SZWlUTWxOSDliQjhvbFdDQmcy?=
 =?utf-8?B?M1l6KzRkclNVWXgwajJVcFJGMGZOWlJ5cmtLMU5CK25oSHIwYjMvMEQrd0xo?=
 =?utf-8?B?TUtZRmgxajRHQkpkRVkzdFptNFZaSzVJMGhzK1BNUHB0cVNpRXVaRmp2U1FQ?=
 =?utf-8?B?R2RwU1drb1pPYmZYOFpWQ3preDlOcWR1eTFhTzFqT0VuQWRocDExNHZ6SzVJ?=
 =?utf-8?B?TmljamFYSmp0aWkyYXhOemowN2hJbVBIcHYzb3hOV1NpenRVUmUzL0lrTWpz?=
 =?utf-8?B?VWNWUWU3Qmx3YkE0Ynk0dG5mN3RPR084bE5NMmpsaE5hZ0R2R3piNVlkeWp4?=
 =?utf-8?Q?AJKGvoOhzBd3hqTY22VDmPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDl5UEFLWGhZYWNPeURWR3lTN0VPbTFxaElRek5ReDZzS2tTMEphbCtGZ1Jh?=
 =?utf-8?B?SHJ4bFZLR05lK2hYekw2bWZWRGdWNDlvSkhJK2p6TFJydnNNT2F5c1pISTRh?=
 =?utf-8?B?VnVEaHZoUzkzZXFKRFFjdmpyS0Y5ai80NlltQTFoRzZPaFYwTThUL1BTWitR?=
 =?utf-8?B?ZmRLajliajh5OHZlMUJPZFVLS3pqK1VGMDBacTVPTlZWdS9wMGhBcXc4S2VK?=
 =?utf-8?B?SGZ2SVFsSTh3UnhPZWorN1VUb1QwUlNhWXlDdVpVYW1sOVVLZENXRm1oZkZ6?=
 =?utf-8?B?dWlWNDkvWitmaHBDaktqVG1yYithejNVNHNtR0N3VncyRjJpRklnTmQ2MlM2?=
 =?utf-8?B?RGVydHZXZWsvUkVPbmR5bmtlUUx6Yko1cG1JclM3ck1Ub1hKdWdLMEErME9s?=
 =?utf-8?B?bC9CRWNFZU11Z1NoYnZQcU9hZzZodzZtQjRNa1BKRUt4ZzZoMUR5cFI1b3hC?=
 =?utf-8?B?Z0FVV0E0eHZlZHN4elZLMkRtZlFiYUJKZ0RCdDBvZW5tcURCaW1EcnZwUlVF?=
 =?utf-8?B?UUpNTk1TbVEvbnpDb21vNkFMS1hlVC82Sk9tWFJQay9EdkhPMHIwUzVjVjJM?=
 =?utf-8?B?L1lKMVpZWU9CMEN2S24rL2duMG1VQ0ZkVE5hYnNteEVsZzBGZmxPVEZOREdy?=
 =?utf-8?B?U292dVNEVzlXbW16cmdqVklhcnhDSU5OT0tydUlaTUxuaFVmSHJrNmlva0Vw?=
 =?utf-8?B?WWtTWnpEUzQ2dWs5cmdiZjhpc1ZTaUlQWTcyTFpTaGJZdVJWOGh1MmM0Vlk2?=
 =?utf-8?B?UzZQekZOSFpubUxXNmRHK0w0b1l1S3VYZDViMXljYUVjdDZxZXA4QmpqMmQy?=
 =?utf-8?B?a0dEZWNldjByQ083TFZReVdxQ1JwYnFPTVFRZlhwWHdhYlRQaC81MDlaR1pW?=
 =?utf-8?B?QjJ2NlBDTEpqZ2o3SDJnUFg0T2VUemhqcHhlZTQ3S1FFZDFWNE9YTmIvTnJP?=
 =?utf-8?B?SzZHSlVxUGdnUUljNGdKdFBmYjZOZGh1YWppUTlRbjFONDdYSUozYS9wSVBj?=
 =?utf-8?B?THlNZ2hLeWtUcnlYTGR2eGFLd05xTWpKYnJvaUZmMWIzQVNJclpycjFDV0Rm?=
 =?utf-8?B?V2Q0R3kvd3J2NktCc25BTGYyU3Y5dG9SM0hHSVJ4L2c4dWZaY09USXJTYW14?=
 =?utf-8?B?cEt1MEU3Z2FaMURXNzk1Vmc1Z2huQklxK0hNenJiMnIwQTA4anVNSnlpVzJs?=
 =?utf-8?B?TmR0UndpMEhZcVU1a1Ftd0dIL1pDZ2poaW5tSzk3OVg2MlZ1d0F5RDMwalBH?=
 =?utf-8?B?OWZYRCtDVXJXWCt1eS8rUVBDZ3Y1Y1pmSWYxVHYzRHdDL04zOWEwS0N0aWY0?=
 =?utf-8?B?bUVVMWpIZW9CTjQ4eTlzMHVxWVlhSVBUcWdISXJvQVkzOVlISWpjc0xBMEZO?=
 =?utf-8?B?eFZ6SVlpY1U5MmsxL2F4TDZ3Q0M2aTFKaGtDWXVsMWpwbjlJclVuOEFsUmNU?=
 =?utf-8?B?aC8yclI4ZkJGT1JCTTR2UHZ0SjdRM3Y2ZFpVVG9kckpaTVJ4dldmTW9hZWxM?=
 =?utf-8?B?SzlEeW4zRVVic3M4cVUwL0hXWE4zUExPRFAyV3N6bHVsekZvYVhzMGsvYmdp?=
 =?utf-8?B?SFB5WTZPMWR1RmVsaWJFK1laWW9mNWtmNlBaaW1NTFJtdGcrcFVhU0NIczND?=
 =?utf-8?B?MDdFUTFaUlZmUWxWMlN1bEZlTFJYd05Kb1d3VHlsVGJ2ZFJNRUJmcTVRMEpn?=
 =?utf-8?B?dEgvcGxLcjRDOW5wZjJlOW5QUHdUbnpZZ21Ia1lnajkzWWRDbzI5RERsUDlM?=
 =?utf-8?B?cDF2c3lIb1RYMElZeDJyaUlldmNmL2cxZU5XY1JYTWNJZGdxV2NwZm5saTlR?=
 =?utf-8?B?TDdqZmtaS3lsK0JES29ncWhBOG5QTHdTemdET1BhV3A5VjNWVkZuN0JGaWtx?=
 =?utf-8?B?UW0xOGpadHlvZDliZFlvMjkranBJbVpRNThUQWZQV1pJd2FNdGlReXdNWlpV?=
 =?utf-8?B?N1E0dk53N0liWWhCanNMSXJ2MUxqZDNvTGZYb2JOSC80UllaYno3ci9tckJG?=
 =?utf-8?B?b3QzWVdUOWdvcEl1cVdDVVljTStVY1cxWlVXUDdhUFBlYlpoYjBMQ2lLMWJl?=
 =?utf-8?B?emRBcWxCNGFDWGRUNXVOZFE3bFdVRis1K2lySzJSRkJtUm9BanpSYkdlMnFt?=
 =?utf-8?B?bUtMN0F3RmZKUVVkTVNYRnpFdnlDenR5WWtHc3RaZDVlQWRmRTl6ZTZGVmVk?=
 =?utf-8?B?dGV6cEhEMTN5UWhrdk5Dc1RRYTkvKy96OXpQSFNzdEw5aVZvSjB2Q2VGQ1ZC?=
 =?utf-8?B?c0pxbTd2aHJocFZ2djFJNDJFNkhLeGxRM3QxRlp6TlZtems0SVkyWkx3Qjlz?=
 =?utf-8?B?WWRCSEJVZGVOS0IxcUNidG1haERyakFhR2tDcWVHZXZxNjVkUHh1QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e17065-8d52-4de9-cd51-08de5e97e773
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:06:05.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErlYfjYVNHViVNWZewfGZJCopLuRQoA2vcOPOh0uNX8YlDdRZ6E/5bZL9a0MkKotYsztRMjVt7zIDAm9I+4QdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8569-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 70CB7A78C1
X-Rspamd-Action: no action

Introduce local soff and doff variables (and related fields) so that memcpy
set_lli() handling matches the sg and cyclic cases.

Prepare the fsl-edma driver for moving prep_slave_{sg,cyclic} into the
common linked-list library.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ff1ef067cfcffef876eefd30c62d630c77ac537a..fdac0518316914d59df592ad26f6000d2034bcb9 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -517,6 +517,10 @@ static int fsl_edma_set_lli(struct dma_ll_desc *desc, u32 idx,
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	void *tcd = desc->its[idx].vaddr;
 	u32 src_bus_width, dst_bus_width;
+	bool disable_req;
+	u32 soff, doff;
+	u32 nbytes;
+	u16 iter;
 
 	/* Memory to memory */
 	if (!config) {
@@ -524,6 +528,12 @@ static int fsl_edma_set_lli(struct dma_ll_desc *desc, u32 idx,
 		dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dst) - 1));
 
 		fsl_chan->is_sw = true;
+
+		soff = src_bus_width;
+		doff = dst_bus_width;
+		iter = 1;
+		disable_req = true;
+		nbytes = len;
 	}
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
@@ -532,7 +542,7 @@ static int fsl_edma_set_lli(struct dma_ll_desc *desc, u32 idx,
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	__fsl_edma_fill_tcd(fsl_chan, tcd, src, dst,
 			    fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
-			    src_bus_width, len, 0, 1, 1, dst_bus_width, irq, true);
+			    soff, nbytes, 0, iter, iter, doff, irq, disable_req);
 
 	return 0;
 }

-- 
2.34.1


