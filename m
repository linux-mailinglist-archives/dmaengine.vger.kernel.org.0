Return-Path: <dmaengine+bounces-8247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC32D2078D
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A248303897B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF72DFA2D;
	Wed, 14 Jan 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTrC6ScA"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FB2E92C3;
	Wed, 14 Jan 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410789; cv=fail; b=HDFR4B5lIzVNPg79WSAc9V4T6ESvmMlpzFCxnr3EA1Qq10XaLf3scMa12Z8rC0aEzgYhnDDPe0MBdQMuF0OI5bJWZ0BALbdXKN9UTpB2iGJuohkVlDLeFQL4fMsawJB1lJJ51PR8TYrOSUpCPRcOCa+1c9w6/GCNWI+OfNIVTjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410789; c=relaxed/simple;
	bh=CSplLpUCQP24MOlkQlc7ScTOpJ/5JoXSLBul5QJfqRE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TRCAQfChBAY0/sooKAZdzVjLccc0XKQY+oiJjghK/fuMmBpXajbvYTpyGW2bMtrzarF8vgjdzdJzFN0ABt+QHUkA1dCztVNiAhZOlFwn3baw9xYRcsejUjqdnhGPTcxDYqkpDCoR37p9dFp5sozmdmGOywT+nJeeJ2LESoNze5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FTrC6ScA; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVpCj6+o1brFOJNncGoXCgOS/MmQ1EUUWhEvD4MQJ0kWdGxM0iDrlBg6dOi23YQuEU7dJhqQwXpRh8w3u76GEp8QtToTjn+vBdLrPfXW5MV+o+m4fa5XIZ5o5OpPsyYxyq9k539fIrqmfQs40kh4DQA6VX2LAe9G4AWOEI1+or2/N151f3P/E6w3qDXLtzdxTD9YfcGuHNRPWX+v3+/yHxLKo1Fx9Bprw991y7dSGyOPxl0bSc9gm62sDPS1j7EkySz947+372U3e8IXVMAnzBBqaIPhWCPXmgLA8cLpF7iVotVS1YZMzCo1FpwSDmbskEWpPZMGO3E3ypQckyNm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh/Z7x7d22l4uD48k7l5iS7SWfdXNXGJDeiBnYuaoAQ=;
 b=ogVLlGEwKAW5YtFHb0u46VykWicQQSJEyLK8sZJIaznhe3x4yHZTEEpPjf0P9l4Hy6fVIDi84SxGkLc+8pNq9cg6zTDVpA3zt8stXx4FZCgNFh007QxwYtPOoZhKHqIQV0tWzp9B8TlrF3I7khdU1suRbBwd7A96CiAm72o9JpANzDUybB75Twkc3iWkjM0d9oQivJjppyPKnA9VqFu76orUuZho3uXbAPo66cGme6RuUEBJJPy/YbpbpPowgWNh6yqXVysnTYs2oT2VaH2C5Wduc/VUzS/KJrI7JTUWQYkO1TmDDfflgXgpskTB5oZKrQLWPnhofIwLd2jNcs1VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh/Z7x7d22l4uD48k7l5iS7SWfdXNXGJDeiBnYuaoAQ=;
 b=FTrC6ScAH8qlkg4XveQPCYLyFbSnD4Y+F6XWeWB+m8Wk7jdvsBuVTlK6n4AL4/FjNwgGzHiS5Xa7i+H55bJRsCW+90yBFW6wG1V/A9oX/6qFLjeXZNRztmcXpPUjg88mPaG+6o01ck6wjFmE1XfeLrDHLZqH2Qbl5Fkb3Y/leU6v/CtE4qCkcd8T97EG0FyMbCP/yw6FrS8NIRf+eX9YSKRMBcPdRatCB1YR5bDpKIWB78RdQAVrYET8v7FIUbowahFQdPmAgy/bgv+Ald2z19Atfr8YfzbQJGgNY2WEi7E05j23AGPwlF9Np7cDlB62URAIgKi9k2Auu82NU98TBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:05 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] dmaengine: Add common dma_slave_config and split it
 into src and dst parts
Date: Wed, 14 Jan 2026 12:12:41 -0500
Message-Id: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAInOZ2kC/x2MSwqAIBQArxJvnZAS9rlKRPh52luooRCBdPek1
 TCLmQoFM2GBtauQ8aZCKTbhfQfmVNEjI9scxCDkwLlgNqjDpBBSbIiOPDN6nvQouVikg9ZdGR0
 9/3Pb3/cDsmIx0WMAAAA=
X-Change-ID: 20260112-dma_common_config-cb87b461296f
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=2509;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CSplLpUCQP24MOlkQlc7ScTOpJ/5JoXSLBul5QJfqRE=;
 b=+z5CAAOjrNqbV8I1cCggesyui5SxOIhyNJV7UKRqOgkkPJUxRx+XTRbk6OPp1yVRhc3PZHnLB
 OCUrFcCwUJeCQKeYKztHPd2clApFeWxERbLyd6BbK3GwutEaHSk83PQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12155:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f1436a-40f4-4c1e-ad6a-08de53902cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2VObHdoMXhxNDlma25lYjIwZEl2MENGL3BxaHlGSTFMZkpqVWJNTjVxUW1k?=
 =?utf-8?B?dEhtbnB2aWFGVWw5a2dkTXBRWjhBWGRrdTczL0JHUGR2OFlFbDZhYi8wZE91?=
 =?utf-8?B?WVg0UnRzTm96YTlRVm1XWGpHb1dmNG9QQ21HRklnSDJoaERyS1lxL1pCWGhk?=
 =?utf-8?B?aDRNaWhnYkVWU0crY1ZzcWVsN2FJQ2l2K09NSi93eVJTNVROVy9JMVVOdWJm?=
 =?utf-8?B?SjF4cUFIL3Zoa2lCQmk0TnJ2NXh2Q3NnSWo5V1FDUTYwV2xLaEVkRldDTXho?=
 =?utf-8?B?SXpXZmxiZkFtbk5ONTNKUThQSlZKY3VoMjJObGhVWU9KNDE5YzZHSXlHRGEx?=
 =?utf-8?B?d0tEaGJjVi9Ccm1IOWxkY3piQkFnemhPWndjR2dNa2RIV0pTZWI5cXQwZGNC?=
 =?utf-8?B?UWtsOVlQUng5NXhyS3BKeCtwSFZYdUlESkI1elhvNytjNUZYSS83KzFEZWxN?=
 =?utf-8?B?bStGcFlxZExKS3FOUmNNcUNrRWpndGJyZDlIK3RpbGpRZWNDY2hSaEc3TnBU?=
 =?utf-8?B?Umk2U1owQk5PNWpHMmlKUlh2Y0IxUGRuVG1tdysvVno0b0NUbEE5S2ZHZGxt?=
 =?utf-8?B?MkNZOXhTenJsRlM1RHV1b2tZR2pKWjMybnhMZ0VrQUo4WmVMUGh6ei9iWTRG?=
 =?utf-8?B?eDhXdUh6T3pBbVFNVW41Umw5QkF0elAramhOVW1DdUdteUcya3gvWTFrZGRS?=
 =?utf-8?B?KzRvTmJHa1NpOVRuWWlpc3RReGNHYzhMWHpYZmtmeTErUnZFUE00U0ZPVTUw?=
 =?utf-8?B?aUZ0Kzl6bFRNVUhPaFpkT1ZyaklMRkJ4cEdpRGJGbW1xUzdaTXNOWGtyRzBj?=
 =?utf-8?B?NitzQkF1UDBpUXVUcnhaSFc5ZjBGQUNzQ1VBYUh6cHBUQzltU0lKWmFFQTNH?=
 =?utf-8?B?NzJSSUVicmNuaHJzbUdsanE2bnpUUy9WN0Y0MGRTSmNPaTR4OUlyQityRFkz?=
 =?utf-8?B?RHJkOEFDdlZCOC9ZT2JSWjRpL1ZPWTlUWEErNS9HMFhicGk1RW5WbUNnaUJV?=
 =?utf-8?B?TkI2RThlMnA3QUZiTHNPZ2tvM3RHRXF5Q1V6Z0NoR2x5Zk1tSTBQMFVwakpa?=
 =?utf-8?B?aExtNEp3dlduN3hiZlVBY21DajBONEpsZEJSV1lNNGkvOUpPVzJNOVk3NW5w?=
 =?utf-8?B?LytJQUJMWkEvUmVaaEdLT0JoSDE2R3FDUm5hL2o0SnpLRUVYak9hUEw0emJZ?=
 =?utf-8?B?Wmt6ZlZEMCtTMmNNZDlWY2hqMnhlSDVTRXExSkQ0SmdtaEFRRm5SUU5jenBM?=
 =?utf-8?B?YlAvczliT0lHRzkxN1NESjQ5TlNDbS92QUZhS3ZlMjZHR2ZuQ0JkZWY1MmFz?=
 =?utf-8?B?dmEyZ0pvaGdkYWIwdWQ2ek5mclhITFg3ME5jdmg0NVRJYVBESEk1cXR1UTNI?=
 =?utf-8?B?VVZERlI0U1ZvMXlTYTdHek1SSzlVbmgwS3J2VHQ4Vk5TbnNnb3ZNdEZBWEZ5?=
 =?utf-8?B?VnZ6STlpNENPcnlyZ0thYmM2ZE1KejltTmRlUStQcXB2emNrMzBCejBxdDh0?=
 =?utf-8?B?NnBQbXR0VmFER1UrdXdYWXRQRVF1N3FMdW9Xd3NpQ1JZNE1PcXdLYTgvd2xO?=
 =?utf-8?B?QWF1SGVuZ3RsQ0ZVdlpzT0JCYnkxcG1JZjUvZjhjM0VNb21CdWVCa2l3U21k?=
 =?utf-8?B?ZnZCRU9DNW1sdjBlNnpQWk40bHFWMDFBWlFGeHVxNEEyK2xqcnhjVzNSQlF5?=
 =?utf-8?B?RGtlYnVHSFl6OHNnYW1KcEFGai9ySU9sSStlTXMvUkJDK1FSV2J6TUdQK1NV?=
 =?utf-8?B?ZFpMeGJIS2o4WjI3VzU5ZktabjZuZ3hqaDdDYTBzd05nY3Q5djZQdEp5SmxT?=
 =?utf-8?B?Q1VLM1FZcWVPdFBxTDl3TnpmeXM3SzhWNG9yZHBkbnlja1diRm9pcXBoT3Vr?=
 =?utf-8?B?WEZVV0lSUk1WZFRCNG83d2srZzB5YjVUWEhETElTVEhWTEtwYXpabEZDeHpq?=
 =?utf-8?B?S1Z0WUwzRXpmV2pyaUVDcXdYRnJ4Mkg1MUdjOEN3alBtZ1dheElIZEZlOUFK?=
 =?utf-8?B?VDZwM056U2oyNlNzY3lYSUtnR2VyMkFLK1pRS2JUdnJkYmI1UW1vSlYvcDI2?=
 =?utf-8?B?LzBlSkkwekhpUjJNQW8zUTBSdnlNejZRWTNvRXZMSHR2RHRvWS9kc3YrSUoz?=
 =?utf-8?B?bnhHblp2RnZ3OTB5ZlQ5anhRUXJ5dUhERTdlS25WQlMyZ256NFN4V3VUZFZ4?=
 =?utf-8?Q?ofnGKWdBoSbMwBRP9HBuGuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjdpZm4zRm5TR0VjNmNFQzl3TUhQRGxGblFBVGZPc2tWRUNTdzBVeDFud1gy?=
 =?utf-8?B?VVdreEtOdENCU2ZDbE5DNEpWQnBDSGw4Q0FVendKZUN3RFZ1QWI5L2o3bTF6?=
 =?utf-8?B?OVFpTktWQlQvN0s2YmpvVlNIN2pSNmZ4dEVTR3IwNTR5clRubzJPRm9ySVVx?=
 =?utf-8?B?T1pJYy9JTkNqQTVvMzNhQWw1UjhBNDlxWk1WZG1iMTVFTXRvNUhXK284T3FU?=
 =?utf-8?B?dllZeHFNYllFTnFPc2h2VHVxK0F3ZUhNdnFCYjRHc1hRRTZ1d2F1QVZIOXZ3?=
 =?utf-8?B?NEdmYTQzMkhzMTFCYmFzS0NTQ3cxRGtBVjBJOE5WZ1R1dUt4MklXeHJZSm5M?=
 =?utf-8?B?VUVkUndKVXNlYWpMc1NlZFJ1Z0VuS3FXWGdld3hiRHNXMGtWbEI2SjJpRUxG?=
 =?utf-8?B?Q25BaTdyLzRsZktmMTA4eDVLMXJuVE9jQmRBRWI5a0txSTVCY25MQkkrRlNy?=
 =?utf-8?B?UnppSWp4alJ1N3RzZVBpeHpidnBvYkoyd0ticXc2alJLRUYrdFRRMzUwdWdL?=
 =?utf-8?B?anYxYjJrYkVrSmgzVU5oV1BneWRWMFg0K2pEMXlIVEN5K09iOFBoZDIwNzZE?=
 =?utf-8?B?MWJJU01lbXltZStvMm0yeHUyK1cxNVA2K0VsTUhpQ1M0dTNvWWhBbW1ScDln?=
 =?utf-8?B?djM0UndHc0M4N25DTXZIeEYwR1JoMFkvaWt5NFFUb3BrQlR0SEF5Nm1XUGRD?=
 =?utf-8?B?Yis2T2RYMmgvQm1ueC96WmduZGpQQTVFbjRvdjdBb2NyWWxqQlpGYXIzQmxx?=
 =?utf-8?B?bUhqczd2RDRYQnc0Z2R3TUFsV2JkNzllYklFc1llbU5uRmJJL3VQSzZ2UjlP?=
 =?utf-8?B?aVhoUzdWSVY3RlNvNGc3LytZSzhuV1F2YzlKbW5FZzE5cGNjSTZOV2trODl4?=
 =?utf-8?B?RlhpZ0xZZ2lJMmN2Z1RIeGd3d0lrd3pVNkg0dXhuWmV1VndIOEJsa3lrV0xN?=
 =?utf-8?B?eSsvSE1jN2RkKzFucUwwVEp6NGtXbUF4SG0raUYrUHY2TjkxbmRFZmtibjdh?=
 =?utf-8?B?Wi9hdmJqWnhESnNGcEhDQjNSWGZIRVZ6c1hwR1ovZXQ1U0tsOGl2RWVPWjdH?=
 =?utf-8?B?ajZGMno0NlZTTFJwekhUMWdBNTFpeHh5RU1WZlBtWFdrT01NdTBVelo5bXds?=
 =?utf-8?B?MXNwZy9EQTh5eVdXUVp2WkhWUVNVVDlnZ2ZXRDVuSWxuWllNWm90SHQxc0N0?=
 =?utf-8?B?bUVIQkZ1OFJ0WmFBNEt6Q2Urbm00WjFPeFUwMXQ4ZzN4aWJLSDN6U0MwMU4r?=
 =?utf-8?B?NVVsbllxQ2JPM0xoUXN1QjFoc2RRc1pDZVRzMEFNR3J5dnh3Sk41dXczMlQ3?=
 =?utf-8?B?eHU1NHV1YWFFNU44M1o4VjlWbjdwQlpQdXlqU1dvdFhxWHZQRzBWUmdDQTMy?=
 =?utf-8?B?bVVJQWNYeFpjajdSelFPczlDTXcrU2RnK3UxcHB2MUZjeEpWUmJYaTUrd0Fj?=
 =?utf-8?B?RVBramludGVhUk5YQlpWNHdITWlCNkhPN2MvK1RrdnB3QVNsZ1V1KzFieFhN?=
 =?utf-8?B?VzBTS3hVaEVVZUF5MzJ2dndEY2dJMEN0YU5zdHRFd3NHTXpuL3hUQnY5aWwz?=
 =?utf-8?B?UDFhbUVGeEJXTEtSNTQ2SDhSWFl6aGpGU09NSy9Wb2dzNytaWEo2dEhZaThk?=
 =?utf-8?B?MEFjUFJYOEUyS2dnVVhDTFRGTTBnOFVlajVvWUcvME9mUk0wNUt0dXVERUFM?=
 =?utf-8?B?YnlPcE1hS01jK0w2SGVpY3VIRjY2RUwxMTFJRWRQYWc1a2NsQ0piQ1VtSmVX?=
 =?utf-8?B?WGFQYi9jcENlZ3JYdDRGQ3NDSFhFZVYwQ1BDdWhqbmpqaGlhcXJieGN4SUVP?=
 =?utf-8?B?YjE5UXB6R05NV1J0K2hFelAyUzR1ekhMSGZxalZxQnZQWXptVXF0TkhiZnJF?=
 =?utf-8?B?YTE5UzlIS0FxdjdsMjF2L0Iya1p1Vnd2WUJuM3ZTazlYTWdBNm9lK3oydWZM?=
 =?utf-8?B?Z0wzWTFyeExUVGxOWmRPclZmbGg4U2RoaElmVTg4QVQrb2JVZEc2R0Vqb3lC?=
 =?utf-8?B?blVHdVNseCtIcXhpTmF6NTJUV21TUWsra2kxLzFNZXNNSFgrSitKN1g3dUlz?=
 =?utf-8?B?SjA5a2E4RndBVlR5a3ZnMlFVOVJxWFlEbWQ4bXo1aXZkTFVhbHlhQ3R4SmtC?=
 =?utf-8?B?Wm9yNWxLMk9xeVF2OHFCL3BENjQwUFpsckxaU1E4T0tWVGVud2ttK3E5d25O?=
 =?utf-8?B?cmRwMURPVlJuY056OTJLWW1HdTdwWm5sVHozUWxsZWVCbXg1Wi9UQk9GektO?=
 =?utf-8?B?c2JaTzFJek9GbUZ4cmJ0cXVaQzBNNU9la2VaTm4yN3hWS1hKR200dkZ0bGxp?=
 =?utf-8?B?N1BXVkpHWmFSUi9mNHNzTVJHMFVEY0hiR1Q3UkszNkV0N2VLMWxrUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f1436a-40f4-4c1e-ad6a-08de53902cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:05.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYs6SdxOgnyEWf0TRBsKKYvYJo8UEJCR+Fk3F7540swp6c1rqHIuLjhYNERlmZ6oTSUg2L6kIp/pj4F9hdBllg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Many DMA engine drivers store a dma_slave_config per channel. Propagate
this configuration into struct dma_chan to avoid duplicating the same
code in each driver.

Much of dma_slave_config is identical for source and destination. Split
the configuration into src and dst groups and use a union to preserve
backward compatibility. This reduces the need for drivers to repeatedly
check the DMA transfer direction.

This change introduces the general approach. If this method is accepted,
more drivers can be updated incrementally.

Looking ahead, this also enables improvements to the vchan
implementation. Most DMA engines follow one of two descriptor models:

  - Cyclic hardware buffers (e.g. dw-edma)
  - Linked-list descriptors (e.g. fsl-edma)

 *
 *       ┌──────┐    ┌──────┐    ┌──────┐
 *       │      │ ┌─►│      │ ┌─►│      │
 *       │      │ │  │      │ │  │      │
 *       ├──────┤ │  ├──────┤ │  ├──────┤
 *       │ Next ├─┘  │ Next ├─┘  │ Next │
 *       └──────┘    └──────┘    └──────┘

A large portion of the software logic is shared between these models.
Recent work already shares circular buffer handling between eDMA and
HDMA [1], and this can be extended to support more hardware.

Ultimately, a DMA engine should only need to implement logic to fill a
single list item.

[1] https://lore.kernel.org/dmaengine/aWTyGpGN6WqtVCfN@ryzen/T/#t

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      dmaengine: Move struct dma_chan after struct dma_slave_config
      dmaengine: Add common slave configuration to dma_chan
      dmaengine: fsl-edma: use dma_chan common config
      dmaengine: imx-sdma: use common config at dma_chan
      dmaengine: Add union and dma_slave_get_config() helper for dma_slave_config
      dmaengine: fsl-edma: use common dma_slave_get_cfg()

 drivers/dma/fsl-edma-common.c | 141 +++++++++++++++++------------------
 drivers/dma/fsl-edma-common.h |   1 -
 drivers/dma/imx-sdma.c        |   8 +-
 include/linux/dmaengine.h     | 166 +++++++++++++++++++++++++-----------------
 4 files changed, 166 insertions(+), 150 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-dma_common_config-cb87b461296f

Best regards,
--
Frank Li <Frank.Li@nxp.com>


