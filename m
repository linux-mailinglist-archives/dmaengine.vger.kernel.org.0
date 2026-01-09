Return-Path: <dmaengine+bounces-8152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E584D0AF25
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF3AE3057615
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A2363C55;
	Fri,  9 Jan 2026 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJdVA8Bb"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100E363C73;
	Fri,  9 Jan 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972554; cv=fail; b=QUc5ybfe0YnM/Q2hQ72LycWffMhZTnzGgZcWVBqVy1Coz5tS+wIULqryeIOJq+YULY1TH1ft7iK/eKn1QL2Cs3i+o0RbGazoNgwfoLnDrOMRe3uOc4Jtuqf7JtavkS2fPeYOe9wkNyuIsnm7ZMU3pJu5mIClYu9VuY0pKCuw6A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972554; c=relaxed/simple;
	bh=u7fTulRfZLwNK7ZgvfmFeAzMaJKinGgg4N76uOfzuY8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=baQn8CVU422j0uLfndOuEogE+CcaXy7dENGHRf1Jx2mixOk6N37bS4qliViSFO3DtEfzNJVC2fW5erl1eu6rTOabc0C5MCuMwDq+X+Se8AgYQyAOCJGAFBFw15t5CGzQ1y8SvbQE8ZXI5oqFm+5r75NIt6H2RUqjdzxQgZzjp4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nJdVA8Bb; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLrsz6jV2hK/AAVtYVApZjYgkFkKIQJRn1co+9ymkRFopp5etkxRKMGaClD82A2MTN/aqRydR7Xmk94Kozc5t9hTSFyFYrUcrETaZWQzwaIcFAZ+DNNA1i+2hVOAbyH0sOMuCTN6cuq07UnPXOS/PaUQqYXqN/Vx/wuemh7ULB0SiCo3K/96DRezo8bNNo/A9VUBhSCZLSKq45u7aAPJOZCtIZ/A3NF2KD0RWsjVqcMZjDnwgOiQyJ5bcMkUFXa+Cf0Dvqhw/ISVVknEL858ZYx6G+3TpaqM0cNFstrVgwG28eMiattvAPe3xUC3ltVRrfvFo7cyr7J+r0FpakZyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rMUD93gy7BrF7Il4uhsuLbNwmQYd6oq2LiS0QYxwcQ=;
 b=KhAQlmQ4jzttHG1MHiWQP8kUpJBNDGAiyqyvT+QbrNlj+d2p27o81aHFd8MH4sR/s+w27wThoALK59CHMbkgtZkBBx/NrhKEBrhnp6cyN+JXdkhgMU+F+dzvggc7S8/T0KdZ1ti8uARcegr2bZfyfUGWit4PmOr2n060jUPuiOYUZBNLrHOkC4VKGEfyi43QwDrlPyzv7CUQXW5wVQpaLkINYpfKKK5obvAoq7RyiLde+MaV14GPjliGiXvsOfIJZRd6ELILbIQkKlc0J9OH7H2LOnn/EOUSynTsPeE2OUAlo40y5Abg85FA0WMkaXnzPn7LJOLhXa8VtbKXHiOh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rMUD93gy7BrF7Il4uhsuLbNwmQYd6oq2LiS0QYxwcQ=;
 b=nJdVA8Bb9ffU9FL+x7Fa6ehU5cCGa5nRQft0KDbmtwcgRTNGbj0+SbPlQ8H8uDPV6CaKnNfV5fSPVDMm2tTGoqn8kwOTul7aWVCEqfzrqhk/TxmX/d9YUPuuqT02SLcLeUqxHznAAk7YSsvTmDcXzkiO7DB4dBmnzWpFSW8O9UPoc07Js/4mUEdEc+5oWLOcVjw5ugUpMq06lsW8BZvlCGxMmAZ3qfAdcJuTt7FDbw+fVq2pDIv5+zixVITyGxmPTGPbFkqKZbHxCAw2xsCGk4O9gaV8KRIfbRjpTK4KCKw8JLpTY/phIIA2OpnRA2KxpTYDQ1xARDGBB0zm88tmjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:09 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:24 -0500
Subject: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=1428;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u7fTulRfZLwNK7ZgvfmFeAzMaJKinGgg4N76uOfzuY8=;
 b=Xy6fJCbH0W7ONINqunvDQeQdEYUsJroWgdMdtpxOygY73nNGA86OyQ+1AROHo4HTtYiM+X7lW
 pnAKzdwo+gfAxsjqAJaFISN8zZx4Y0kJRJgkw65vRobcIXnOjlw4yRK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cc7ec7-01e4-49ba-a336-08de4f93d505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGFwMkRpSzRRMXNPNmRvMEY2WnFZNktFRXNFRUhRWEVpZnQyV1NxdVRSbklz?=
 =?utf-8?B?M255K3puQU9rUjQ0dU1vZ2JqUjNHZnhLRVNZQjdTRHFORVVRRGJkREZRZSsx?=
 =?utf-8?B?UUt3MGc2YjlZVUN4aXZtbjVUbmhqT1BXajkxT3dUQ0syamsyUng4aEoyay9y?=
 =?utf-8?B?Z0ZxN01XdnBNdWE5WjRHSWJ3UldxMnpKaUd3cGdFclNtMmR5R05SNk1DV1F4?=
 =?utf-8?B?ZHg4ZzR6dDVMa2JwQlQyMzhkeWx4a1BkL2tJUGFxcTB0NlNudTAwS21TTnc4?=
 =?utf-8?B?MmNuTHBnSHRzRTd0NlFGQ3I3VW9RWkd0NzJJUStxTDhtTFZHOTgxd0tIWUVP?=
 =?utf-8?B?QWQxSjlWM3lWUnltTndjZDdxVVBOZVBkSHEySDQyVmg0K0UzamNJN0s3RW1l?=
 =?utf-8?B?a3IwZVZpbTRxTTRwcVBiK3hXUDJqcEQrRThiWkNiQWhqNmZYcElWQmozeEtW?=
 =?utf-8?B?eXlQc25ZSkZLMUpGRjFJSWN4WnArQmJ2OHNubjN1SFQ5bitkcTdINjRkSFFF?=
 =?utf-8?B?Vm1rZ0dlOGg2OU9vV21vdUtTeExnZ0Jwa0J5TytkN3pGK2hKbFhvbWxTcEND?=
 =?utf-8?B?d1hCR3pHaVZkbHFJN0FzOEFPQ2hYbEJMS2xCL01OVWpKaWFHQ05FMTNuekli?=
 =?utf-8?B?Mms0dkFJbnZJWksvU3hncElzTGVON3FGeEZKWTNTditSQWo4aG1UVm8wZVZH?=
 =?utf-8?B?MGVSR1QybXdjWk5OUktKWG13bm91UXZNT25MbnhuVk4wVFFzMExVSUcxOEtw?=
 =?utf-8?B?VHFUU1l1TEd3Mkd0eUt5ZHE0WUhwQ09oSmh6U2VKbW52dmE3c3hBdWxvM1gw?=
 =?utf-8?B?UXVGM25zYmM4TDZaS3pUeXJpUFpwa0Nhbm52Mnh5b0tFa2wwK0Jkc002c0xS?=
 =?utf-8?B?ajNLa2U3V2loZXBlZGtiS3NqYURyejBhazlYbGkvQ3pQS3FzSHV6UGlZMzgw?=
 =?utf-8?B?ZFhFRGh2bEhpY29NQUI1YjJJQ0kxUU55WnRETm1jWFBYTUlxbUZlaUdxY2ZM?=
 =?utf-8?B?Vks4eHZwdkI5dGY3K3BRM01EZm44M0lRVnpMWVU1NGVnbEZtOWljWWxrVTFk?=
 =?utf-8?B?cWJYakR0cWM5MVVZZy9vV1JlS05WSnAya2Nma3k1QlJVSnFZVkMyR3VjbWVk?=
 =?utf-8?B?M01zTFcyYVR6S2E3dExLYUJoeGl2ZkJPQXdsRTRSVzMydWZwczVoZW5jM2tu?=
 =?utf-8?B?SFd2MmlaeUl1ZHFOVk0rN2hEbm1VcGlZUXA0ZVA4V0lWUi9UdENESEZSYlg0?=
 =?utf-8?B?NkhZU2NxSnVqTGJCRXlyUlFiUnhSMXRkc3BNVjlMb05EN3JBTHNHM1dxSENx?=
 =?utf-8?B?WS94WE9yL3RmMG1wQi93SlpKaGtSS1ZRQmJnRWlYa0pmb2p1b3Y4TG4yOVJj?=
 =?utf-8?B?NWZsNFRjc3BPN2pkWmlDSEpaVWs0S0ZoeVVNMUZydy9TeWFiY1FQbDVUMW93?=
 =?utf-8?B?ZVozWVN6dDV1MWVwMGEyQlRwY0lRV2NXZnFNbENZMi9XWlFyZXpFcG1FZVBx?=
 =?utf-8?B?YU90bEhZTkhoQTVRK2c3WkY0K3R0ZmlDaVlQbjQ0MjFtbUd4Z1hreWlMYzJj?=
 =?utf-8?B?bld6ME5oVDE5WENIbDhQN1NLK2ZXU2J3YXA0cHd5R2dzWUx6bFdiaFAyWnJB?=
 =?utf-8?B?YjdsZHF1UGFRdVU4MWRjbTZNYUJhTXFqRmNvMEs4RlYvanpqTllWS2ViMGVG?=
 =?utf-8?B?TzBYQVR2bld6cnZ0RHB5NTNGeXNaK2duNGZmZFBmMExpZGxkTkpLZmhUL3RB?=
 =?utf-8?B?VGM2U1pxWUlJNzg4ODJXK0tIbDVVOS9HUmZOeHEwZ0tVOG5wUWRrTVN4UnFz?=
 =?utf-8?B?RXZGMzArd0NOK3hrUTNESXpTQU56MEszaVA3Z3BMS1ZZUHVZVjgzcElWNFhG?=
 =?utf-8?B?Z3RNNk5KN21nVytEYk1OcFNNQmFaTDlOTEREWlRNaWFWa0x6bW1xZzdYSDBR?=
 =?utf-8?B?YWttVmxRNEN4dXY5UGJ6bS91SUdmVjgzYWJjcHI4Mmt2Z0MzMFUvY3haQ2FK?=
 =?utf-8?B?MkhFbUxEanhjbG9vZmFBeGFUdER1QmRYbTFHc2srOFJmY2N0QnFhdGFzcXFk?=
 =?utf-8?B?K1V5QXFkS296SjFreXM4T1dFZlE2Y0hKaUx3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WC9HOGw0ZXpSVDNnUlowL0VuNXFiYWNEdExvZk9oZnl4NWVNL0tZVmNKL2dV?=
 =?utf-8?B?ZlZCQXdabEN3RWY5OTR2TEdlZDh0aGF4ZVdvZVNhOXpKMXNIb3IweDR5Sjhu?=
 =?utf-8?B?Zlk5ajVqeFphV0oxWmgzdmRGdlJrdk0ybHhIQXc4bjFYVlJMbTJna0FsdWE0?=
 =?utf-8?B?L1V6ekhCNWZ3M2RQREJHdHJOcGlhVUJ3b2lNMEROMEF3Z0pvRWtUR1FRMjhX?=
 =?utf-8?B?bkwzajFnSGhnMEloSUJiQzVBYUxuUE5rdUwraWpPZUV3WnV3NThOK3k3QytI?=
 =?utf-8?B?Y3V5TGh2dDNET1lXb05maWEzdURUM0VJZklPZDhQUDBhc1Z2cmdtazJTdzEv?=
 =?utf-8?B?SWFZdG5mQjlXT3pWRnNKdDZDdndSU2ErL2N5d0pqVE5HWDI2eXhmSkVzUTBo?=
 =?utf-8?B?VkZYMC9wNHlZWHpMUXNuaTRsNzd5NlMyTHpRclhrZEJFVGw2TW4xZjJTZlQ5?=
 =?utf-8?B?dGtkUUZaVnlaRVl6RVJCUm5Na0tYZnRjaUkzRzhIMTFRbHZGR0VHT1BDYW4y?=
 =?utf-8?B?L2ZrbUpXQ1YyV0xNcEdFeFhnREpWT3NSWnM5V0c1YXRHQ1hILzlJdkJOVWVR?=
 =?utf-8?B?d0JNR25Wc213RVlqNjFXRDNBZ0grZU5CMUdVa212NHA5TmZvR2dBbndRUWJ3?=
 =?utf-8?B?NUQyVXNsM05UbGRnTE5Zb2dxN2M5QUw4ak91dlc5YjZZUGs0aENHWU5QNFBp?=
 =?utf-8?B?dVRZVC92bFUyeUc2dVBabnVBUzQxbjkvdW9SREFaYUJSSFlRZkNpMXlvbUlk?=
 =?utf-8?B?VHNBYjNpZVVUQkdwR3NHbnlxbkRtY2lmQlFJMDBxNXZIRnhpUFBPRGVCTGtF?=
 =?utf-8?B?KzlZY2RmYjI1T2Y5WEFnVnp6MjdxaW1HME5DQW9JSldXcjQvWEplRmJKRktR?=
 =?utf-8?B?bVJTa1R5RjV3U1VtemJDZXlTdzgrQURjOHBqNVVGZDdmYzV2a0VQRjVuTjlz?=
 =?utf-8?B?TG9FaXFPNThhVTZpL01aSmRGWG0xM2dzTmVNOHhGOEkrdlVUNzRSR0lVcStJ?=
 =?utf-8?B?MytDcm5kQTdwVldyYkNBMFNDeXl3RXRmQzRDV1lvWjZ0NkZPT0poQVhoZmFv?=
 =?utf-8?B?UkMvSEZjQk5abHB4Nk12dGRsd25KTS91RFllK1MyQWluQThKUTZVelE5eWwz?=
 =?utf-8?B?T2pnVVMrMkkwMWk0b2E3MiswUGJrYmNIKzEwbVZRS0hFRnFWMktDTmUxM3Ru?=
 =?utf-8?B?am9SZTI5aVhXSGQ5S1FURzQxTUh4VXYzWGFNY29yWnJZOHlhcEduSlZRby9z?=
 =?utf-8?B?VVkwZXlMUHhCbGpSNUFlb0w2RXVCb1dLVHFJNldrY1Z3K091TXYyQTUreEFE?=
 =?utf-8?B?WHV3czlPVjhEMlZxUzhmWjVGaDJmZUxjT2Zmb0VNN3h4RS9yVUJEc0hoUlFQ?=
 =?utf-8?B?RThwNXE4dlVVTFpiNE5rbnU5MUlDVjFLN28zSTNxb2J4ZU92ZmNUUmVrUHdG?=
 =?utf-8?B?RlVRYlRJMnEwS2xYKzR1V3FPQkRxbm1ENWM4QjltVWNvOEEwODVOaHZxU2Ur?=
 =?utf-8?B?TDJ1NUtDQ2JPbXR2SmpQRTRFczBTV1hGWEZQZjRXcmtzRUdWakdKZkpaaUUr?=
 =?utf-8?B?MVJtOG5JMGpKLy9CbFlLYW9oK01LY2NRakJLNGlwREZHM051STBDMGJTS1Nl?=
 =?utf-8?B?dEpmSkZvVHJNZldRNURpVFNrV3k4S2tpbXhoQjRBdFFwc2Zaa3l4L2lPMDlw?=
 =?utf-8?B?bVlIdTR0ZWd4QUVnRlplM21SU3Z0TFJqdFRtWjZZbm5HelBKamU4K0lDbVRa?=
 =?utf-8?B?elNDT2ExTXBXZnkvbWlVT3BXS2dJblVHWnE0UUMwL1pJdGI1MSt0dXJOQnd3?=
 =?utf-8?B?Yjg0aGNpT09lb3BuVGlTR2ZWRHZXd1ViYmc4RkR6RE5hY2xGZnhrR1hGOUpV?=
 =?utf-8?B?OFMzVGxWa2JxYzUyaFBZSlh6UjNyZHBNZHlYT09KVzRsZGpiQ3ZBR3UrdEp4?=
 =?utf-8?B?WlVSdUZaYkkxT0RQMmhOL0NvdVB2ZWxCZDA5dzJHb0VxanhFbXg2Nk5zeENN?=
 =?utf-8?B?a0ZFcEtNVVlHSGFrL3ExdVRvaEhyMkl1UFFlL0x2N1M2ZlBVV1ptVWt4MDdQ?=
 =?utf-8?B?TXp2NTcxN1VGTllHdDhvaFdjNXBLK2c1M1RkamVrMUVFbUlwTW9GaUR3SU1M?=
 =?utf-8?B?RjhOUEVSd21iMi9Fb29PWkpHTFQ1ZHhXYmloVk4yeTkva2s0SHFiK1ZwZzBM?=
 =?utf-8?B?VG11WnRkWkdMTkkzTjhxek0ycWNrUU9SVTVFM0hweG11dTVoR3RrZ0xEYU5X?=
 =?utf-8?B?bENKZEVBSzNlRm5sdzNRdGVmYWFMTWJ3SG96K0FrdFRuU01XWUpuMmc0YTho?=
 =?utf-8?B?Y3VDdmMvMVZmc1VqVWtPWkIwcEZHL1oxWUo5MDBQWmJIMkZHWTZVUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cc7ec7-01e4-49ba-a336-08de4f93d505
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:08.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPPnuKNW7gT1eoOLZOctyVErv3MVHIyqwBXG5WXWILD2BJLUjwaxZ6fNebGhuKBxHSTzXkjec0pjfMUGJwyURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

dw_edma_channel_setup() calculates ll_max based on the size of the
ll_region, but the value is later overwritten with -1, preventing the
code from ever reaching the calculated ll_max.

Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
It is uncommon for a single DMA request to reach this limit, so the issue
has not been observed in practice. However, if it occurs, the driver may
overwrite adjacent memory before reporting an error.

Remove the incorrect assignment so the calculated ll_max is honored

Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
 		else
 			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),

-- 
2.34.1


