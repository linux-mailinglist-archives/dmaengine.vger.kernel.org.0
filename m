Return-Path: <dmaengine+bounces-12405-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vc5iFZIaVWrxjwAAu9opvQ
	(envelope-from <dmaengine+bounces-12405-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36074DD6E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=exHqw4sM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12405-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12405-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EA99301D767
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E34343D8F;
	Mon, 13 Jul 2026 17:03:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09953438B2;
	Mon, 13 Jul 2026 17:03:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962230; cv=fail; b=uHiCxmqRxEcqjsZQGrlux8fuVic3K0eMmzX2Z6kHRQgPu3/NYi7bsfLGQ8gGcYnBG80KB5YrNSCJjJjngQohUZgwIKGTru7t37nvw8USFLP83bZjsbTizGbEi5ZO/+srtb1roI6pW7dKAzaE5IDQtgZJNAy9v7RuVmbGMApnN8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962230; c=relaxed/simple;
	bh=M4odctgfzBETkZew8EcEHVlXf6u9qdi/vo7X0vqNvuY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WaOS5OER+QGYK7GvI0Z7SYvTV9qABONhzc7dXGaZzio4SLXDSzZbzehUYDKshkHLq4AsPTCecLrT30w67GkcchhqmY94l0jjfh5GDo5fX/0sOrr9a6Xkk2UkTQ4akvSZyBATPDvry3IIVjt0BnbtJi4oOWS0S83eyuRKO3BTzlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=exHqw4sM; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyLC/t/oEWTlPkYK+mmRbs1TNTXLj5DhDUAppYUtcKmIWLfXyZO6AUmLiJ69YB2SwXvZ0FP2j3DWQSSFZWgjAKN1q3j5RgGkhqc/RqR9/m9m1XgBV+2qX/6gToUiczWDhL2YJe3w8WB03AvFECe4z1mSwo/atsoK7/E8KYsfIJupVLRGjMsLugIfVpJ8c+uVFoEByKeNDdwaxQA3NRdyMMhvBNBV93qJIPdYQALXuJoP4rS2EFa8hvZzzzTwY/6mTb++0zOR+Kx/TXwGkOPWEy6El/Gb740BT+DbYWxeOefsiCmTOE0+/QlFZDvdCsR69jnICjCPMue+zjDKaMu7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmEomCailFWZKKRc0zUQw8FYrZ/qMFR/0IEdLLVwMJs=;
 b=gZqFQdAeN0N//iQmx8SB5x+r+9HBjQyh7+KeN/L/9I4CCTJ5oq4Sn/lofHZ71cHXek5sffGBzG8lJ9cENr49TriVVFCZhMk8xGHoQYbtQ1ljlbHALP4VO5FvPwy86F6vlJT1nU7W3/OFdDi2DemHkt8DvzlrR6jmylZx1nRkHZTVuek3uqvyU9LYsn4rJD9v8NIso/b8WtQF/PhIE0jBlP194+7zNZQq8KHUq/b4Hzb2lBrkFcM4Es4ajKqtbjIBVcIDKC/9XlK4FTtp+rfE1Qn+NC1oQt4cj4Hqw+TAjMpPTKNHhi3i+kSjqPuxbVqf6S/HUGd0gVGB4acgrHuA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmEomCailFWZKKRc0zUQw8FYrZ/qMFR/0IEdLLVwMJs=;
 b=exHqw4sMUkr7UE1ACiZ2CLlLgVraRhAz0hY8tF/LIa12FKefbqJBSSctq2ISS3ajnflf7sNPq2IBlPeg+I1aDMb3HdB122b1PLgc8KSNFcq8WbyLtrKAfnXgL9+JLpj9VmNGBKips8Jh120jr+qDVzE0yFe8Fqjd7iF/2JvHj6R+/MfVFJJPqVdcoH/eRO6fu7rF+FHS0Li92kskmdVl/opIe+EZpSkdixPM5WbBNlulGhSSKGzwUX6Jk+P6pvQJH1M/CRDShy5eJImAxID/M3ETOnvWaP0p0tVyikd9jIKCUtMYnjttWj7Xa+c8wM9R4H+pQ/Ld0KrpR+zDvzTDjg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:45 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:22 -0400
Subject: [PATCH v7 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-4-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=6971;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1vaHqzrsWKOaOsysWk2j4TrmkwB9RMsaZMMXMwdx4uk=;
 b=AEzdrr1Q/scjZpTq+4H2gMZpe20o39H2/0KUZoffW5x6GAtwfgJoSXLolfVrIl30b3dz9c/jb
 nl3d7Uj30GgCzavrGxu0bgVcyTQduu00rRUSKbXeRrA4Ybd+iAHnSOR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b575d8d-fd32-4410-f3e2-08dee100b32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EuWqNrjp9lv81LWjVLv1ve8PO5YX4J4kJBuDegNNDJoThbH6/EkP+QWVXk4fdk/iavjHLPY8D8fs2lX/BMy836Q/6Nn2uDaj/g6yhxmlTu57Vp88BbpY/LJ/9RfErCtB5dWbR0Fxxu4FlPz/JtjNz7WLgTKmSvL1F8G4bBkg0x0/oT4dUDzZRwgF0YCsql0ToZOmS58z+RXo8UHr/gh2/D2tY5b8J1XeV555TAFxQ7UJwEqps3UzyT8FMnCrQiG6PYdbGr/VmR9En6Ymii79gy9xsXwB/2RhGHc0LW7JxQXSHobvDirO6zqtWjh63QkexJGJq0Fzw82qBM308CgBu1LainQxNIe0aqJXxoaGUC37rWcnOZzvY3p841pk9b+LOfHboG/C+SJOsG0sx+IKKdt+H7ddmM9TJtK4NFBghiMW+Y8iuD3L9MQN8lea4gAZQkyAxJwkmDMUfIewcfaQPiQzgnyhI3nUh6d40flv6EmEcBd/tZ/wSjRXmKz0o5WIsbrEVB8IoudZebkEjbRYJycd/FBRZLTawez551jyEJBblkvEEp5Wdj3G+lRCVbD8a9lAA1lIZWr0E1x8fAIDGXojPIgteer9GectnF1YBOUmfJLjuNMzrnuR0cA/qnWsD8jTqnZgs7fEVYWi20c42DYIVgCqmgUuKhfYElREB1Q5VGnNTRu/YT8kcSSxcL4oWsPXSzxk4klVw7cnjdvVQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlBIbGswM2VlM0VseWJHKzRCQmNJLzZSMWJCdEY0VDRwd2l1ZCttdjlZTjND?=
 =?utf-8?B?S1ZMUlQ0WGRhUWlZajl3MUw2eEVmNG9PUllCajZzS3E5dFVmNW52NkpWdjh1?=
 =?utf-8?B?UlNZazJZRUNrV3U5eXBBc3pHKzBBbHpQbnpKbENUUnhDWndoWG1kNjU4RTdK?=
 =?utf-8?B?anVta2xGZU53aVJYL2FWUFp0VTZkOFNIeGUvQUVpc0dzUkEyN3pXZ3BvZWx2?=
 =?utf-8?B?ZTJoSEhZaUJjT1pOa05HSE5ZMno3blF6dzFQdEQ5S0F3dnQ1QnpsSUUyQnI1?=
 =?utf-8?B?dmM5WGtKcVgrRUN5Y1FPUzRvUzcxS3RyeGJlQVdNRWQzWWZQTUN6MkNvaUtl?=
 =?utf-8?B?S2ZGbTJOeGZtUGVaQjRZUWNkc0o5b2VKb05BanJzWG9IQm5XelZsRzRVZ0RT?=
 =?utf-8?B?OHNCcnhOaDh4ZDZGUFp6NUlhdUtiRnREMkw3cElmZmkzcXVMeXNnWWwvNkV4?=
 =?utf-8?B?RXQwMUVpUDBMdWNuZ0EyaFJjeU8vcWVlblpWOHZEdUVabTlhQW1UdGpGdXZ4?=
 =?utf-8?B?RlZ4Rll2bldqOEM2S3NEb0lYMVpocHNQN0MwbVZUTUV1WGdwelVuT01mTlgy?=
 =?utf-8?B?RHE2TWhjRHJLbmZxbXBKZktKbmFxemJ2emxUV3cvMkp0c2NxVGtIVGJGM0F4?=
 =?utf-8?B?emxPTnFBaGNBZmdnMjkvSFJSNXhUNXRNeFZPQ05DQUwyL1pRaTArNWozeENI?=
 =?utf-8?B?UStJVXBxK1k5c0dGRnRxT3FZSEdDWDVQOUd0Y1Uwb01jeDZmVnB5NCtrQkVz?=
 =?utf-8?B?UVp0UmZCbG1TOVBwK21KNmFNUTJQa1BkNXkzZFhsbDkwR2NhTC8yL2dSMzBq?=
 =?utf-8?B?V1hMa0g1SnpkRzJyNlBDZzFMQnZ3d2VIc2w4enJLK0dhcXVWRjNEb2Rqck1E?=
 =?utf-8?B?Rm1jVmV1RGhiU25ZRWo4Qy81TTYwRUlGUlR3K3pOLy8xamRwNG10YmIvQ3lC?=
 =?utf-8?B?b0NJd0tPR2xsaUdsS3BBMzZtZkMvaVFMTFV5bW1JRkFBTXg2WVk3OEF5MDJO?=
 =?utf-8?B?OU1BY0J3cGwrZzNyV0M3N2RGQU9EZHVSRDFnYnFMR2dDK09la0ZEaFFrdE9P?=
 =?utf-8?B?QVRnZ29PbFNTMkY1RHhDNVp6OWZRVkZBaDhRRE5EOEUxcUN2b3hKU3Q2SnRM?=
 =?utf-8?B?ZWZNanVXbzUyVlFUNTRLWlBmR2tScHl3SisxMStpUWU2V1hHRnJjalZuRXk4?=
 =?utf-8?B?NklPNXRMamVaYlhUVDdlS05qblBqbFYrMFB0ZjZOdmFlOFB1WmlIa3lFLy9m?=
 =?utf-8?B?c0RTWlFoYytKdzBQZlR1K2tlRGxZb0tXSDk5dFdkd0w0L0t2Z29OSWdSR1FS?=
 =?utf-8?B?OVQ2TGhIcUI2NjZJZDlSam44eldsTldOVURWZ0tvZ3F3WWo5ODBxUHMzaE9O?=
 =?utf-8?B?eUhFM3cwV1h4Snc0bTVocUNzVW0wamIyT1ZNKzU2ZS9HV1JRVDlUcVJhYzJo?=
 =?utf-8?B?OHZVT2s2dEtRY2VMVXBZdjBGWWpGMDQ4dzh1MEg0YzdjeUZ5U1hzemlnUnNL?=
 =?utf-8?B?LzVsYTBHbld4bDNHVG0xWVVaTXdWM1BDRmlaZGV3WXhsNDlQNGhONHQwbkRh?=
 =?utf-8?B?UGVTVVlDaTZWc3JMdXFjQXB4SnZqa081WTJwM2VwbVdwOC9pUTFzQS91OGpt?=
 =?utf-8?B?KzIralNwVFdpVnlXeHlHZ3B3MGxkM1NuR1JHZExXTXY4RFRQK1JWdU1zNjhy?=
 =?utf-8?B?THNsZGp3L1JhSVZBcEZOb21vYTNvaDVCUXRIMkFyNklWOHJyb09mV2hOeUph?=
 =?utf-8?B?cnluMFEyc0dWR2dqSkZkMElrSkNYUS9INGwvRXBrRGJVYnkybTZxemhwWFNQ?=
 =?utf-8?B?MTNmbVE2U1RSQ2VWZldhN1JWWmx2TzZtWlZzVGg5ZkhXa3dsZ2UrZEhWTm5M?=
 =?utf-8?B?K2kvalRnVkFNc2FYeVFON3cwNDJrbnNzTHNkY01Zckh6YmpRNVhXTjZrc0VT?=
 =?utf-8?B?QldwaFEwQ1I4R1RWNUJqTHV6ZlRtUlJwNEI3NXBFZ2JvanBlbHFZZ3k2NWZG?=
 =?utf-8?B?VXI3QkJxazdUSC9SeGtDcjlhUW03Mm9McHBhaUFJUzJiMVpHYnBoV0o3ZWpl?=
 =?utf-8?B?V3VxSHNSa1pjemRwRlNzem9CakZJdjRkVC9wUy8renl5QWtLN3k3M3VlNGZG?=
 =?utf-8?B?WW5PdGVuVUpTNzgyYk83VExoNlFIeXVyZnpoUEN0akwvdStPZUNEbE9wUkpi?=
 =?utf-8?B?MTFOMWE2bnlibE56UVdHMm5COWYvbkN5OUZROUcyVU9Ubno4NTllTm5QM2ta?=
 =?utf-8?B?RCtiYjRSMXd1OVl4ZXBXQjdYcDNGS00wQWtHZ1lJc0N4cWp3ZUFodmlsRnJX?=
 =?utf-8?B?Vlp0TzZkN1N5bmMza1VaS2ZjUjZ5R09SaFREak1jZ2huS1ZnbE4xTUxzK1Iz?=
 =?utf-8?Q?ehU4xQ47T/lYzYY+rc6aKGjWCi19Z41HFHww2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b575d8d-fd32-4410-f3e2-08dee100b32f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:45.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2VabM7loBjfDkJvAECGUJVVo4bWxJZd2DxlsViUE0zWRIde4MFSGe0mhiZwxDnnI+IwxNyzyjHujU/nFO0/2FvALyRPxPxv2jdlKin/vi1yqtH0mQTy1gP+XMC2DqWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12405-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,valinux.co.jp:email,nxp.com:email,nxp.com:mid,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF36074DD6E

From: Frank Li <Frank.Li@nxp.com>

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


