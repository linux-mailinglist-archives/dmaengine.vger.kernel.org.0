Return-Path: <dmaengine+bounces-10581-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOTQIZ0vDmqD7wUAu9opvQ
	(envelope-from <dmaengine+bounces-10581-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:03:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937559BA72
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12825303D159
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009783BB9F0;
	Wed, 20 May 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kNT8GzNT"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64033B4E9E;
	Wed, 20 May 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314478; cv=fail; b=qGPplX3FII+4z1e3b9Hs9aZmUrVLaNsFElOkojeRqEiVZVU66cQHnMR6/MpzUH2xjO6IJNVcrEPqgJkVSrHP07WYKEVe9mqA+JsOU26WdrDsZWfNcW3hQIe9T30RSLCyenyBU/YAuNJckb+kaABVfeHYEx2UNfNhoaGHvQVAs2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314478; c=relaxed/simple;
	bh=4oynAX7QP0LSKBL9MNdn2Qv38GBqghHuW6t+3Ylr9Bs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rCLKtEYABtqvZrBOrIGy28m0yKR3s2NpXdGDckiXpNqAyN9Si53B9fKUwWz+yjLXhiopTWrQhAMVPKTw2onseMZGB6a5qv0gAxdoIJBsLGH+MFBiNlBGU2G1LUtR+fU1Pl6xR+ji4o7R1z6zDaZeMnLIOPmg4hUKHO6iqiMT1tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kNT8GzNT; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaSeR4S/6b49e7bk8DVsbg3j2Y+CzQRh9Yipx7lAa/wO5o5/jFBxz16OG1CHJK9ntdDDNEMtkwzFbRwKzeAWCPRcvLSPba2GwKLyPqYbvmWdtluCyWXxfEd1TgjXF26ftkNt+jzlv/IN/KgpliLRik5aOucouXmxOj4PGZcRGhYKdBD0vBTwjCbMopmYxgjQEk4F0GBtApIz1saAoWxY/aJk2t71Yv9W6fLUyCvWZqgkJIO3fmE1swyAXARTMK2zGuFrmPzt2Sz8JFd9QpCc3732kI9ceIYIz2kpE40CaMJ3mosOQnH1rNyrVXC3X8RRbrHxmtj1AHJEqCvaSZjn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtGtmbxs22Dn6Sqp5hULlAlSENMMX8OuHSRQ3W0Zyq4=;
 b=Z4WxuqHqTjx1owljvq4ZPwhCJp1ybrXgv9Re8sW3F4mYPGg15YX0TCasZUvRS49TInpx5Svr9VyN0WW3W0GFWBVX5o2ss6jCTm02KMWNLN9sOV/B34I/hvUYgUUU85JnW7ZR151b5bBnGxW+s5X973iWOz9Hy5hR8ft1e85b2C0VOIn/dcrA0ey5+gCYH3ejsciUG2HrJezTQjMWAFwUEkmthX5NSGnYSUuBSpIkwiln4IP5GI28Chp8e8+pmxsBqevfZvSZAf9lP3Bci03ppjSOW+bFha9oHnszteu7tsfeDAZryZPpnaZOpMdclmftfjbyVgwowEOAID4BtbR19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtGtmbxs22Dn6Sqp5hULlAlSENMMX8OuHSRQ3W0Zyq4=;
 b=kNT8GzNTLI+wfTKWoOO4h7vG16KCKD5Z/IdLyU88UckGfX1p9+cbhluYACM9rAkqCP0Bd+fICppshc0iER12u7Ra04LcIEE//ZhDQ7beD4bba1KJcNFs5O/1I/Lw8OJv6Hywz3xmFEu7QFTJFCJIopM58w+92neHZ8AR3Azwi3jgOY6FFyRoBWDTdhTBnhdBHZqhGz6znp5s3cddjzTeyZIX2NIqZjKWwlyt0qki207PwgXZHtjjCvBkxZSIu6/FzCaJcXH680uNK8qMctLbrYjDKkEGWf/rgap+6dM8sNhRqhVKJa9bJUu+z0CSB0gk7XcJBuk/UAC/h8yN88ZgsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:06 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:45 -0400
Subject: [PATCH v6 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-4-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=2281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0Ia3JYWUtUCQVv3nu0hL9dzhhqfNED3UBkrlVo7ppgA=;
 b=oCakWrVMeXa0fw0UT3qBvi++H9EoiD5XhuH5RV+QTihJVjQkqyCoewDvopY0QOghy1rP2f4jP
 W0NyeZ8NxYoAQBP9sarNK2Rqt0Rpzrm1xE/J443B/57hED0UoQzvE4N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f303641-7c19-4792-a1fb-08deb6bb4af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|11062099010|18002099003|22082099003|11063799006|7136999003|6133799003;
X-Microsoft-Antispam-Message-Info:
	f61v4+1sYYXMpL4lV/GdmmWsFMX3ZiHMqwerxZtTbOD9AXKelC8vf/AZvUVOVmUkGmDo0x/eDRcd2oa+gUHWl4jIZAvNNa2rha27MnIalpYce7XCMyh8s7tRfruvJKCuXld9KYIpx4Ts/CNd9sAvQoSmJKbmpVSvejuJB4YdrLUA7sQoLis2BOgGpCNeTg9adXztBH83DBcBSBXCrQ9sdbUzt20ZY8rD2+fDJEYm4Starv8iS2glrtbGHWQ+1ayhZU0FRFvSEizP3mffpHADtaaGZWbspeLdz2cWhOYJBLIzBZrsWNsE9qCL1SzQ5v4UMwVC3sizPFPxl3DauS8V5/Mi8YVT2wjZUQT4xKIGTNdmdLevLKNyc1JK7VRey7qOJQTRhJ/gONCqtpq2NPjZY7vQtF0Z8YMC3Zsq6MQFLoUU6M9ioaa6TvlMl4ioCITfUEgzudp05Jp1Lz3Ue/DM3YKl0RctG7UWLjP1uwJ+FZODAxmyZS8sU/PTYIojbgFwVLeiQO5uX/KXsXKJ1VyI7iA74baClzd9mfjqR848hs0HsrPBZYMbnKwtHjDw1I4dwEyqM/P4qDuQW5bA9ayus4spk7ROyX9SyTTnmL9XtDwX04RSiz42oUH9lXmEl21dRLRL5EToPlTRuSjcazvWop8qzX9MijuDEcNZ3r1IHXR8+ajvukTf29tDuv4vH8ytrteC761bXVkB553RBtI3Vd1sYdl+08sPvlWWythS23Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(11062099010)(18002099003)(22082099003)(11063799006)(7136999003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHlmVDVGeC9oVE1peHF0RkVQTHdHSDcxOWZ2VklLMW85QUs2N3Y4QTJSbGtV?=
 =?utf-8?B?c1BVcmZsV2NyQTRsUTNtMUlwQ0ExVDJmSEtSVmFZaEcvaTBqYUk1TERGTG9R?=
 =?utf-8?B?cFpyUk1JWWptTkRkbHZjd0F3UnBINVJBUmszaFl3RmlsUXEvV1o5WFVsazVP?=
 =?utf-8?B?T0xHL0tWN1pLTDEwUzliYmlTcnBDUWUvN2ZIaEFnYlArMGhJTkhVZDJtS280?=
 =?utf-8?B?aFlJL0pCS21UWWROY3dST2llZUsvVzNucWtHSkVwaG1WS3pwUUYrWDUwM05t?=
 =?utf-8?B?RnJIUk9ZdEo1eXdBNnI0VERTNWR3ZUxOekIyeW1rRTBtdzFoWUNHQkIrT05H?=
 =?utf-8?B?MysxMStkL1JzOWhPTmJmMUlCUHhIeit6b0wxN2pDMDdpdU9mblpyOUtwNnRF?=
 =?utf-8?B?MFJ4bUVpZTBGOURtTUhyeGo0RUk2aDAvTS9ycmpWWDZKMFpKbzhrT0ErWHJO?=
 =?utf-8?B?LzdPYVVkaDV1NkN1NjkxSlFrdlIxaWhTOExvSnBPWWZCOTVWT0t1MlVScXQr?=
 =?utf-8?B?TkgyNng0YitQVVhyU1FPT1BnTGhWcGRxaTVRODM2U2VPN3FZYSt6TXBnRDB0?=
 =?utf-8?B?WjlXMFJtaENYL2VQTDYvLzcxeGZmVFpPVTk5UzJDZE82RVFzQjRPdzN3UHBV?=
 =?utf-8?B?MG5zQVJqdDEwdDkzM2dUb0lDYnZNcDBVM2l3NU1aYlJ0eXlyWkFEZklCMnBY?=
 =?utf-8?B?YnBpT0VBMGNwN2ZYbUY2L295VnlQOWhhNlNZTzZBeWxQUnA0a1pwWWZ4cjN5?=
 =?utf-8?B?WXlYeERORHcyWmFLbVpwSDZEa3VtVlZPTEhxTlRVOEN5dGZ5LzhzaHJ0MzQy?=
 =?utf-8?B?VG56SDJsSlh2VVpRTkZpMUVQREgzVzdxUERJek5xMkJQb2JmaUtnY2dkcHZO?=
 =?utf-8?B?L1UxalBLWUJsR2VWM2FPMGdtNmlaaG1DV1NVZzZmUFZsK3FtVm5mYmFaUkQ5?=
 =?utf-8?B?TGo1V1dDdzF0U29qNEJmTHZYZkZHU3YwZEdURDlFVHJ3S3dQbksrenFBY2pL?=
 =?utf-8?B?YVZlNHhab2M2d0hNQnRvMmlzVkk0Qk02NUoxendyNXZ1Z21hNHFXQTJDT0Vu?=
 =?utf-8?B?OGY4TlZQOFo4T2tTYVRralppcXE4a05icHFjN0x0d2ZQbnJMOXo2S0pUWDFs?=
 =?utf-8?B?d2tMQXJiTHBrNE0rZU1YVHZsMEliczU0amxnL0lRcEZ3ZHFxenREVmJhSXI2?=
 =?utf-8?B?T2JLVkxESXhtQnV5cFZ3RGZhcVA1QVNqakN4Q3JtWXYzNnB6TlZObnF6QXBo?=
 =?utf-8?B?dFVRY1B0WnZzZTByQ1RIak81amR1MVQ5bDFPL2FiQXMyS2x1Q2RMZlJTNS81?=
 =?utf-8?B?M2toY3FyN2ZVS3ZPRlZWSVJZTEtObVIyWnpRTGNYVmxGb2xOZnB4NmlPUlht?=
 =?utf-8?B?dU1aQW1JcDlGME5PSTY5ZFczRmZvRlFjd1JTdGhZMnRBSTVjMURwV2t5Uy9J?=
 =?utf-8?B?TlZwNUN1bkNyL1RTelY5M1dVS1FKNDQ3NzdDQUxkR0JzMGRSMCs4eVJGR0l1?=
 =?utf-8?B?WHFGWUZCditlSVc4Y1Y0d3JtSlk1SGxvd3VKR2NGQm5OOWdvYXhpR1FDV0dD?=
 =?utf-8?B?K1ArRnhjT3pWM0xoRzFQdkVTR1ZBdnJHOElrY1oybmp4azhlNHFOSVhHUnNB?=
 =?utf-8?B?cVVkRTVrYTlwTkkxZ0RZS0haN3JVdFAxT3BHcWJXK1J5U0hibVpneGdMRkI0?=
 =?utf-8?B?NUs5Y2E0VDFZbit0R1B6SWZKNkEvaHFYVzE1VU53bkRmYnVzMG5ROEpPcFJx?=
 =?utf-8?B?ak9NMzRnajRuYUZZUlpSblh1ck1qUHg0akkzWks1S2hFMUlvVGZ6eWE4SlFo?=
 =?utf-8?B?cEFSb2s1a0xhQTRuQ0x6MnBnNG9FcFhxU05Cb2MxTjVPazV0WTh4cWRkbmdM?=
 =?utf-8?B?QUUwWHlXUzFzOHp2U0pWeU1kWXlIMWdPR0hSaDVaMXlTeDNyNndseWxRc0pk?=
 =?utf-8?B?ODJJNTNlRTFSMnQ3NFhNRk5jM0huSHBQTW9FcjZkYzlvRW1UblBJK2lyZkNx?=
 =?utf-8?B?V1ExRkdtcW40MitQcWZpWE9KVnlTZTdKVGVOZmM0Rm5UVTZyNDJaelhEaVlv?=
 =?utf-8?B?U2pkLzMvcVJYcFEwalA5OFlSWkptdENFNSt4Z2dBaG5zVDJ3cG1jUmo1Q1JV?=
 =?utf-8?B?TEsvbkNmVFV3ZGJtV1BRV0wrTkVTUVFXNjhvTjNMdVJFRCs1bEJ5eitUdGRz?=
 =?utf-8?B?UUxyeTI2TFZ1cDBpUkMzcGVZdGt3eW1mbHZHZkhiTlhtZC9nMzJObjNRL09x?=
 =?utf-8?B?d3BBSkVta0xmRmEvdkUzbU1ZNzlLY1Iza3NPRkxjWkNObjJVeXNrNU11Zmoy?=
 =?utf-8?B?aDU4Tm9SSGJuSk9WMzNCSUhuYkdXc1d2Q1VJS0lJdjlPWVhuclFXTEkvaE9I?=
 =?utf-8?Q?cWO3d+Gz78wpUThs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f303641-7c19-4792-a1fb-08deb6bb4af5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:06.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtD4jl3Yqn47+ZJBZPmmbdUZzeuN2MPObB/fO/nWDyGq/8rcuGMYMln3OvMxpYWGV4neF6i2ik+YxwPk2zd9QhuCT818TAeBEJ6kaWUPEfG+Wr5/hBdUo/wygbW/5b5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10581-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 2937559BA72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- check dw_edma_device_config() return value; find by sashiko AI.
change in v4
- drop context in callback.
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79fa..92572dd8131e6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
 {
 	struct dw_edma_transfer xfer;
 
@@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config && dw_edma_device_config(dchan, config))
+		return NULL;
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -970,7 +974,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.43.0


