Return-Path: <dmaengine+bounces-12243-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkkoHzfDT2oIoAIAu9opvQ
	(envelope-from <dmaengine+bounces-12243-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:50:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AA7331B6
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=LB4cKt4B;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12243-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12243-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB45F30B8581
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A9426D38;
	Thu,  9 Jul 2026 15:34:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEA420E75;
	Thu,  9 Jul 2026 15:34:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611250; cv=fail; b=q/hmSx5HLks0L4kVE36b8HT2WqbnW6tj746tHgi9CJBCWxhyLF64fKO0ELogy6teCjauY7esqtuQvWE50+tTBNqs2IT88IxBBjwfm194gDXnX1W1RDIqw8BkKHh7Zr4yGwTWVXXb/1j0WHZsiTQ19dNzYbZ+RXc4KEOKbNqLbok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611250; c=relaxed/simple;
	bh=ka9kK4KrQsiFuQ8VaCuD7Ocm0ukLLA6FePwvwbbbQ5Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QE4XKy5H1H5RIKVuC/IypXkgMlrcjvfqRNWTpRMqSYJlTo0df2I9VtvO+uZsFua2iY0ix5s1/20RBB9BeczTs2tCK+w7BPYa4aSmJlCtX3U1210+lSCEENCUXfJ79XBj+vdQpuo77zLHdH09urrVgM7ZMORUmfPora8YHudCD7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LB4cKt4B; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+CUXNj8WG2vVz/6/YQ4Fl60M1ykzkAMpZ9WJutNVM5uFG3Ib1NJuZOnksDVI8tECpJ6oNUfOZZoA6UdR6MMMG28Gq4keaH3JsK23K8wet3yMbjT/Z5DizQXzvE+oYYNavmjvBwi942QqIL6ogwUpx3aZuTnKsk7NIpmsFoNQgLxFEAN0L/pL7XHxPc04API8vCgxxVZfGqVSCDode5HutfX3J91nFhXNFpBgog5E7W2bJ2PBHu4zVeHvfAwzDzpz+3wOO25qPJuA6n6E9kZMsJRl9taRcoMwovh07w4X6niw0tfgeaSidjagmBJKL6FfSKo5hI2qYKxU1X3KwGiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=LuT5wCVcrNQm+eAa8YNsZcpE93Lt9A1CbbTKYoZ+2LmxxjqFaDQu6Lq0gqxdSiD0bYLwIhL37NiSmCPX9Z36pbyFroUpy4aWDHLiaszbRD5Y5sVKzOeF6FJTwIWVflLz4o+btQ7F/TFysjikh/jISl59X5yuCHKGa6wNPHLlRShYDrDx1TrG2KDuIOhD3rn2Bty3WezgGxTiA1Wyfouc6M+/ChM5oIqnlcNLmIZJA3xaCogQEzOR7SJZcyH8aYsbZKfGIc2w4u3ZWg7VNfNcJDHnLYXhjDXdmvN+KjsTjG39xsnkgGoHjHesdKTQoszKaOhf0sq/lt30dHfMyKQY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=LB4cKt4BpgWndxUawVx9XnDbQNtXrGU2RCJS+C698+9FXMLllkGwxLuTcA4+UcGPT3HknZkCGcdAv4KT7ruFcnhwKKcaSAg8qJ3l1lFqPyNm9V4yO1WzBDnEozrRfvXv6NiDwVqgrXdTWzPtGAbe9mXgKzBsUE4NjBU5mB3rgk6fd8kf8bCRjf7C2h/zLPHZiLkG+f6wP/zi2bmhaFXD9qf57yNPxnNkhTCkKs+C8Lbd6AujouPPilsx3Z5lARAO9MHwHaIVGaPjs6tn0cJ23QLWWtzv/9XpFHWD9uAklD65p4ZCKZxbtPcu1okGlyqLbxjhQbkuM10hlckec+hAlg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:34:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:03 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:34 -0400
Subject: [PATCH v5 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-5-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=8061;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4EK0D3D/aLmHCCY94Jg6tvOeSLTRe5eZn5kbz2AZWXQ=;
 b=uIIuacaTrrRrTV4ikeKbvdxJb/uo4sCSz/cOeIx3YUlr8U8U150G8biYCl0YFutGEBj4TyjEk
 /J3XCqKMih7BfOHztPBHTQB37h8cY1hCnLJg9rqoqMMMjix8QJ1+2q3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: c3da39eb-8ac0-4dd8-d8d9-08deddcf8118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Zseoi/h/gEbIKN9lwsUdJD1QEdxtFQ4IPaTCSV9IX9Fn/b1BRr09CSM/o/c+X8hM1RylNCFBP19BEclurLTBWubhe6exe6r7cwncCSYdVwysJC4nJfwE9wZ5Ua1bZanSRGuIAsCMUty7DtZR8yXDYlpAjmGrUwa39Ye6pv18URRx2ZDLYWCKV7W7WUIF9Ge6PX5sw9YzMzelbrpMWkBRPBFlR1HgxMiMmxMXuW9Kr6/cJxxOHgnkY68CBku0iL8LPpIPlmCP0bQ4kVRDWwjTosHhDwSimP9KzXN8wlAhN1jH0N4YRRrcJnh8hFnrJL4gSPw/IYsGXKBxk2EBIFHYowrSOdftYOQeiGNBkTTOuPQtGP4FFUPATRRuThWI4L4Q4PYQ9zdQ/DBPR6uiv0bfOVkqWVXn48bOnUQRo8xIHvLpzYTlMKmEh8Xaxovb+rsgebTW6BdHHvQi6CS9mIM6J7kNqoknFUI2UXKp2dP7iyCTGkgCTjkKyYCZmrly69ugHocC3vdq6Z92yy/iiJ6ceaBzC/YzTbaEAASfpNrwadTfh9q/VMBQ3BsQegnSZW1tRsu+eT1SP0shCIRKy0OAIBSq7beTI5LoRmsU8livwzw5qG1bSFbw7P6sLtiGWZrj5hEZt9+4BbKeNxQihcmKER74Xm/HyIqtbiCDg7ehWrbM73UjfgfeHxTgxp24y9rOPR6TGg8ut1pun/KZ6GrLQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU01b3ppdEswSWQxMHRiK0FlMFVWVE5vVHNVTXNpcUJESWVieHo3QUhZL1hi?=
 =?utf-8?B?eE96Z2llYjVkYUdCVW1NbS8zNDdFeDEwVTlCM2hJNy9iaUpVbUZBN1A2N2Ns?=
 =?utf-8?B?ckVIRDk1azdtcjJtSy9MWTB1SlRNRi9qekxJcWg0ZVJOSFE4eFhBc3ltSFJy?=
 =?utf-8?B?SkR1WWtKNlVmWjVDLzNXcW8zMWtPQ2tOT2JHL1ZPclB1YnlxdEVYMHFkdHR5?=
 =?utf-8?B?RFh2MGJXQ0IzcnFYTTlHdFVqQmdKMDFTWlZKcG9LL3Fua2gyM1F3QTNFb2V6?=
 =?utf-8?B?dTRFbFplckkyOEEzeVlQUXI2THNpcDVqcUhtVUVKWlRMckNySnp5TFE4MjNJ?=
 =?utf-8?B?MU9TeXBhM3JLOThNRVpoRHJBSnliYUdEdnFwZUlBejJMTU95VHFLWlZWR091?=
 =?utf-8?B?NWdJZVcvcVdxZkFjSGs0VGs1eUt6c3gzRmNwdFk2UXJLL0FCaE9CV2VvZnFM?=
 =?utf-8?B?VnNPbnhzRTdxbE1SVitEMnVqazZ1SmhNNHRiejIyTkhXeHhOdXJkd2FkSnZ5?=
 =?utf-8?B?Zm5YRXRXYzJVTmxXUG5LSjlMQllPY2hWVGxlVVZyM1lVSllGdHpSdFEvZnZu?=
 =?utf-8?B?NFVBMkFuelZhdStIeEU4ckpYL21BR2VPWVRhRURUR2htalJFZkVyWmd6YTRr?=
 =?utf-8?B?alIrSDNMUktaekEzMGtDV3ZvWU55cUY0TU1ybHFuVUlRWXlHZENuUWI1Mm5E?=
 =?utf-8?B?QTBTSWREY2hMdzlVY3dBNFB0KzRtRTF0RmUvRGVuMWxaTWZRM0lQaWZzRmRr?=
 =?utf-8?B?OWptK2hDTlBBTlRkMnhiR2swRWkxemlVeEwrOG5sQ1NxdzQvOHh2MjcwRXRm?=
 =?utf-8?B?WU5FQ0YxVzI1SjVZVFRZTWdMOGdyRW1BVERLblZ6TDVpd0FVSnJxT1IyTTVH?=
 =?utf-8?B?SEVvQSt3TXZISkJRd3lyVFFiS0FvYnpheERLdFNGZVkrVVFGRlUzU0YvdTRs?=
 =?utf-8?B?YWhVYlAxTHVlR2Qrc0FuWm0zZnhxVE90MTRYMmQyNnovUVVWTHU3MDJ2ZlMv?=
 =?utf-8?B?bzdERmdZK3YrYmFCZ0FTSDZhVmc5bm4rU3oyaWZmV3gzT1U3cGtzZlo1N0Jk?=
 =?utf-8?B?M0hMQjNjajdQZ2txeXFqNlZHOUpxUG5wakREZGQ3eUNZODZnNE5rQlNYa2pY?=
 =?utf-8?B?OXhHQUVhRlhOVWNyUUpDcThEcnZ5OG5HSkpkVHp4RVJWTjQ1ZmN4STRSMEYz?=
 =?utf-8?B?djJ0S3dIdVVSNlBLWGpUcE5PdERNVjZPSmlQRzBXMDA5Qk53U2FwZTJBcHlh?=
 =?utf-8?B?aC9Ed3VRMXV6eS9vZU1aeXF0UDljQzdWdUxXRXlpR0pLTG54V3B1VGIzTThU?=
 =?utf-8?B?QzMwZUJoS3g3WGFZNG0zN2tUR24zS2xtZVZDV0FpRm5Jb0hVNW9ZM0pXRVFO?=
 =?utf-8?B?bCs2dmIzRUFabmlDS2RtVFdHa2NwZWg1WDl3dEQrcUwyTXJ3SURJWEsxWmxx?=
 =?utf-8?B?R2xhbEdERzRPOUg4QnZyT2JPdkNmQjVTNkZtVTNqZVhqNkhVTjFyNHI2TDZ0?=
 =?utf-8?B?R2hXNEJEUi9zWmFFNHV2a1Vqcy9HRk5hL2dnc3NYU1RLbld2UWl6a09ZZlVR?=
 =?utf-8?B?Z2VoT0hWd202NU0xaVRsSXlxZ00wWXlsMms4bnVzTkRuTlhsYnN0b1Z4VnBC?=
 =?utf-8?B?bFJBSkJTWXpNNDNDNFlRb0pCYXA2T0tGSXFSdGQ2eTVXUlB6SDdGdnlMUk42?=
 =?utf-8?B?YnFIV09xY3pkbXkrQ2RRam90OGJFMlBzYjB4ZWl4N3NhUWU3akIweWpaOGRR?=
 =?utf-8?B?VkE2cXNKS0lqRjk2NlBGcnZ5dzZYdTA0V1dWSXdQZ0VMamxpaUk4V0dRSzh0?=
 =?utf-8?B?b2JpdFlPcWVmYithd2FSMDFJRkVuV3NRc1NtWUtjWUlGVXIwTFBaRHllcEJW?=
 =?utf-8?B?RncyS1YrcWcrV2xjYWNRRnNzcWVhdkZlRWlYaHdyMXJZVzdYOGdyTHY5MURV?=
 =?utf-8?B?cEtaSThGZSt4bUxCNXhQY3hvZUxub3FUU09paEg2cE5LenczS2pVRGVXOElD?=
 =?utf-8?B?aHRDMENGaUtWTElFYzhZYmhJcW9iTTB0RkJqcWxraTBaRXNuQXJiZTZnOUho?=
 =?utf-8?B?eFBJcnVrZ1gzczUxOExqN1dHOVk0ZzFqbWdFZVVCSTlqZXFuTXdLZTJJQXhS?=
 =?utf-8?B?anl4THB5VGU3V21MTktuR0NTMko3NlhhMjJPT2NFWEdtUCt3VU5mNzRHVzUy?=
 =?utf-8?B?bHVLOU5kWnMzUUhFWjhON0dET0JKZGFFQXliZEdFd1hXc1JweXRlOFFod2VE?=
 =?utf-8?B?Zk9LbG1XVDM0VWQ0SkZEWE9rcGl6bUJ5WTdrYVpqQkhUTU40cWZxTHZvSTYy?=
 =?utf-8?B?TDRtK1E5bkRjOGlpdm40TU1qR1o2T2hBcHl5MERlVUV4TDZGdEhuUWRxckxW?=
 =?utf-8?Q?NuE+dTH+RE8QSeuuqyPvZU9bBSKBevz92EpkP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da39eb-8ac0-4dd8-d8d9-08deddcf8118
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:02.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HNByghLHLSywYqLgK4qfotODMF/JG6VegdUd41O2vwhRP6ZxDR7M+we1TsGh7VQGBtFyJuWSgb/SVKFBXgL2TOD1PavT0Ih6azVHnq3m7phhnT3m7vaVrIyjv507I+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12243-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E6AA7331B6

From: Frank Li <Frank.Li@nxp.com>

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4:
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  54 +++++++-------
 2 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c341aa5343417..8d38867cd9983 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 156b1cc225091..31bbdc6a40642 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,34 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,33 +260,11 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-		/* Set consumer cycle */
-		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
 
 	dw_hdma_v0_sync_ll_data(chan);
 

-- 
2.43.0


