Return-Path: <dmaengine+bounces-10378-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDVFAj1aA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10378-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:50:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B4525153
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68AA5305A8A9
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976B43D5C10;
	Tue, 12 May 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGcZmONd"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1653D1ABA;
	Tue, 12 May 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604197; cv=fail; b=ELDb7rSX78XYybPhYtEn60cYXu5e+445YCSSvWOkCyzM3lTQSE2fKb/G7zvRKe2Ywvm55gWMNJYrZ/BeuxGAEOe4PyCImNYoI7bXpdjm2nO1vRirEAQASrgpci9gaaZXUIqHANU9G5O2UHA11eRivXIaPJPYnPe48HfIQ5fUMXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604197; c=relaxed/simple;
	bh=koXXyKc1hgZdKRxgXzvlujpzrQC7NdnB7of8UmH/EuA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SNSwC1QCm0KdmiBX5/aYPcJcIbYq22dm0RqMpiQ5kUXozYUDpTo981C7TPzF/4ytsV5xplsWYw/gmtMOUKFC7CFszcRDj7jg2ZhmdT193fFSwzwtzWj+GkXUp1k+wNBgXXN7Oz9MQam4IZIrRBdtDPAaZxTC4HvZKDpHLb4/93Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGcZmONd; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTQ8a9NuGRSa5HEFNXzR9RxqZ5WNEZR6yvbUL4lqLnCbsA5DZwR6SLqW1jDJYBj7SFrZL7RL9Nrb7SmgCpwY7t66eLeFID6osfuFhwXN9F7zh2QaabAPOpmX66BO8hkMEHAneucljHHKHMowYh2cD04HNCqePLf+Ft6N3PRvyj4tlyQlprLJKzlozqLD+KO5Nw6ZZr9dgGHVELLjQGEzLv6iGp9SXJPwwHv4rAEAuBa6dWd0+1CX90dmWPYC6MecRwNe0ncu22aGpX9crCWRnRce4abHMV722jy8LaP7ailHQcH8Feq0e+8roTHFbDlWtzogsrJM5WVnrsXCWPTL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uplwv4EQrFrvunfm+7xhscX0/FQTAzucHl0DFTTQQC0=;
 b=b/5QQ9uFeXrG5ZGv/iu2NkZDjFsLSngLBJtTmqmNWCR6QilYpiP9M45yO4barOJ8QRGnvkgmMEzfxMCU7PI+UX8uzLGPJ3+UqbJdgU882zFVFhJ0jiSH+QUnG8RMR5p2ehoCOwNu1bQMSYmycmHJx9j1C9JNCHlNhBPGuaplzWUVrp75qomO/CUbWpxhSkJTP5y+ijALutKZYMJjwdimTI4aAyVA/Ax3Cs3ZOhODKYBR26Ihnfe87COLC6nIgweSN+t+IYJ444PLkFpKO606ySiQfTbPq7W3h314obu3s5Y53djXYGKEQpeIU3kC3pUDhu3bfLimq/xDasRAgFg5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uplwv4EQrFrvunfm+7xhscX0/FQTAzucHl0DFTTQQC0=;
 b=DGcZmONd2mF0ijk2CGttwIxkQyaSgzREYBpH0Nux1UvwvMRvl/MmV+ySZGT+QpDtsWMHz+PIZ131jTThraAC+2SU+5Zwjqcdb3ogR+Ki7vvU4nb62M3WuN+ttPmLnvxuPNYYEVjw/hZELunLeNk/5J5OZ7q2tTprTp2j/hWaVOhkEaLR0tcJlkp/u3vO68VjAZsPzLXvPAeDgHHan9Zfd7dN9Dffx+ji8+nywOHc76Qar8Uzq3iqHv/KeuiddmKZul4PiBxmj/lllCKPH3K6N+mNEac3ZelQWyXSZkhRSJGUJ7Dq1gigMhkEHlJBZtO2EBJS3q62pWhltQot5+yUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:43:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:43:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:06 -0400
Subject: [PATCH v5 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-8-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
In-Reply-To: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=4679;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=koXXyKc1hgZdKRxgXzvlujpzrQC7NdnB7of8UmH/EuA=;
 b=BDefYlhtpIm9DYMrHFZ//INSsG5rzADrCx3Lzsor4xguMYWVHQ0pgaLHr+Wyzz811pzTM09BP
 IN/iHSISJriABHcEmbjCrxH7l5xwkWja/N65Gvx+0e8+XsycyJEGJRA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 454ffcbf-7b7a-44b3-98e2-08deb0458e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info:
	KWlsy7kc3HDa6Vuwlh5F3Boch6YDtYPL/83nrXtqCXHIVxrQsU7oD9la1Cdu5fBFhruoxrCbU7Mfgp7stwcgj0IMf2qwErvBElwRINWlEekJw1AiN81EnvxjW14QJA6BTptFaxrGX+iqYMTqva+c8lD5rfU+QdSdhzg+y6WxyLjFu0zoTOEjTpyZxLTvcs2vLEBtipYgtck1ExzMm2KRev4VXKX4BujjbPtDIV4nqNGm1bsBaTwC8nf8ff7v2e6vx5weSGSrY4e5S3yQoRzbEfvMrJNLkEtr9rbuO7R9vsBZVmtxNkaj7TI2qiIYLkLMDV1sR/PbJixudjXfBQT1tR5q6+bdapiIJIYxaMeEPNhdzTuZLA0RU2b6KL7l2NfPr3jxrvpAG+sa768wwwZM2PMoiyZnlZYrAXloshFCx+h4ERjDnF4vGLMq4CiVdxrOKUqUXEUFH84Yd+QF0ZhASWbnaMb1F98VfYeAXJenBSNb0uC8UWcmlf/W5qA0LIrvYnp1U8I+2zUCxI4Acsr7n/s7X77rhn2wSuTOfqijvGx2X7HBXNmMKKBmWwpeuDUfMTAIRAh2k87qHxvQv6zVl/Xsw1ot0kI53tM08xetNF127COD0qCx4RcSJDInJ7WbvJCodpKVXK3VaZzoLhdRAfYhwCrBp37aLiPPDXq1G4pC/va0aZylZ1zxYPJAel+ZDKZjG8n8eFo/07cnPAEe1vjJLJNkBXiQZ5GYGNd23rnlZ5sgVt2GhzwpgRYiEw903nWsHwVMdc3tBUsRgI06vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFRDaGxZS2NEQXRvbHJBOFVseG4xZVpqNVhDSlNJT0JSZnd2NlpXVUgyalVO?=
 =?utf-8?B?ajVodWxhR09BdDFqMWk4WEhzclR5RElBL0ZSaGg1N0Eya2JMYnQ1SVZkY2Zr?=
 =?utf-8?B?bG9VMkxENVkzbU4vcHJsU0w4WE5mZ1lWN001U3BDTXRLWFlEYUIya3pmQklG?=
 =?utf-8?B?Z2JCTzlPYXFuanBPZWdSRzI1RXkrOUVpYU8vdk9TNS9uVFZvQU9jVS9WN3Ey?=
 =?utf-8?B?SEJhUDVyUU9zUzBySXlXVmhLSHNBdUxKSmZWYUpmMy8xV2tmMUhNZXh3YThT?=
 =?utf-8?B?L1J1T3JnOWFJbUtrTE9mL0hyNDYyV2FzVFhjTTdGVjNqL21zUnVqSVJSOHJ2?=
 =?utf-8?B?ODdOZ3UrbVM4WFZVbnNManJhcktIQ2M1cHc4OVg3OTVoZEZic2Zic2x4L0hL?=
 =?utf-8?B?QzVWQ3JBQTNxRkozMHY2eGhYbmtNeUtRZE9oVU4rQ1NKK1RrUkJnY3V1Y3lY?=
 =?utf-8?B?NXJlT2E5UVl3TU9iMlBCUFZJMlRUaU5LbWRXaFNKcnVDYVpSRlpGckt6N1B1?=
 =?utf-8?B?TkU3eS82Wm9QcFIwVEMyZ3puNlFwelJJUUxNQ0JzdlAxSnhHaVVaVmQvbWJu?=
 =?utf-8?B?Rmk2N0QvSnNRMkIzdVJPZ0tzc2hLMXN5NCtHWFBSVVd5dUlveTA3cFFSSWIv?=
 =?utf-8?B?clhCSGxsM2VraVI2ejFHZmptaXR0T1FweGlsQTJPVkozYTNvTU9oTmtIbHh6?=
 =?utf-8?B?c2NHMVhzUTErVVdMbGY0bEpHVlRDY2xuYVFrVlorRWxvVitmWFNOSWdlZVBq?=
 =?utf-8?B?T3VYN1VsME40YWZFQlhZVi8vMkVRTGhjWnBpcEN1N1IzeHJRazBJaWZmaVRN?=
 =?utf-8?B?MW41ajMvZFR4ZVJkYTlNa2VGRTVSSkhBV2ZPeGkxRXpvN1NLQVpCb1gwWmxz?=
 =?utf-8?B?MUs3QU93dU5OWVZOSjJjeHlDOHc5MWhSeVpxYkt5MDZWQjdDMzRPaDlXb21j?=
 =?utf-8?B?aGlxanNUVDlrSmhHMnBoVW85K0ZFWFU5M0o0Y3pXMnBFTGNmM2dORVl6Ykxw?=
 =?utf-8?B?OS80dHdzSXd6MkpmY2pidW9zK0ZwV3hza0RWWEgyRjVHYUJIQmJMbFEwb3Nv?=
 =?utf-8?B?YXBMNlFlakkxR1I1OVZkQVdNME43aXlXVlNLSHBkRnF5dzZOaGVSbmFxYUFy?=
 =?utf-8?B?dUY4b1hjL2dIbWphYnNGV2NqMi90Ymx2Zk5EVGgyZTZuQmFoYnVvMU5aUVBk?=
 =?utf-8?B?OUNPOXBka0N1OTVQYVZaWFZCMXY4Y0E0QkNSaWNQdml3T2JGNGpTMFdjc1Fm?=
 =?utf-8?B?elpvZ2pqODFUOWh0a3BLLzRja3VxSDdNeExzcEN2L3dxS0FvdExNakpzak1O?=
 =?utf-8?B?MjcxeUpoVGZMYWpHKytXSmVlRDkraXJ0aFZuYlhYZ3NJbmtxTXI0UDI5VEto?=
 =?utf-8?B?bG1hbUNRcmRDcXcweDgvYnZ4MTdEYmFKcjR6aVdaOSt3dHlPcksxVmlGdnJL?=
 =?utf-8?B?c292UEhTVDg1TFgzc1AzRmJwVkV3cG5iR29iYStnc2M2YnZiRFdmOFhha0FX?=
 =?utf-8?B?SUYrUThFSldlL3I3NGkxNXRwZU9SMk9IZVphTmFMS1F0VjZYSEMzaytuSXFk?=
 =?utf-8?B?dGhya1Z3UXZib0g4aHJsZDlZSTgxMHBHV2JCNHNYSHhTOW9RZy9Lcm4wQjVr?=
 =?utf-8?B?RlNHa1NUZE4vZ201cStDVk5FYnBpc2JCalRzR0dZTE1PVHFZdjIyckF1MmFY?=
 =?utf-8?B?OW93VVNyK0lDWjRsY0pXL1lwekJ1RExLdTh6YlBlbmFsaDVSVXRzL2d1OWVF?=
 =?utf-8?B?NHErYkM4Z1VFVTdzYzFiK2RZcHhBbUNSbldwaVFKVjB3cFAyQlBZZzJFMlRh?=
 =?utf-8?B?QmFjZEYxMXlxblZhbmp3aHVYWDBoc09pL2RSWTJCa0hrdWY5am8xcjZ1ejBH?=
 =?utf-8?B?NzdUYXA2TWlNUnRENE9Vd2lFK25rOVU0aXQ3MUlkejBxdVlKVFI3RUFyNzRq?=
 =?utf-8?B?SlVVdnFSMUNiSFlvUFBpcXJ5RGlkSzV5T3hJcW0xSWNtaWVmTXJCWGFaV1JB?=
 =?utf-8?B?eHVYT1ZhRFF4a0ZzSXVoUVdadlZuaEk4b1B0Y1Y0TDJWTG03MUc4OEJrRjFT?=
 =?utf-8?B?b0dZaWJITHNYak5xWm9WUmFybjVxeXFXdjdzTDdjb3ZGOGM5WkxjQ0owRElZ?=
 =?utf-8?B?ZUtRSzY1Yk04NzdxM3pHMS9ZcGxBOVVibitsd1NFM1AzV2R4bGtZZFYvem8w?=
 =?utf-8?B?R2ZqL200dHJESTNhUkVJVzJ4UUMxQTliQW5lNGxySzkrVnY4OHhJN0tCT2JL?=
 =?utf-8?B?THhOeEc2ZmFmdWxyNGxYcW9pdlVGNEtCUGJYMFZPK1Uxd0cxZTVKMDdDS1B6?=
 =?utf-8?B?L0VScFErM0xhOEhGRXYrZWFxaXJJYjQ5SVdXTDFCUkhGOFZDSENQQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454ffcbf-7b7a-44b3-98e2-08deb0458e12
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:43:11.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBW1N+y6GQL1oeGZQ3G0e33/fFWBgXBKWvHYownf/vHCNzmoV/0FC4/NHxJAfnxw6MR4YL5p2pvJEfv/AAiHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Rspamd-Queue-Id: E38B4525153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10378-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed54abf4ae75c465dfe0a9bab37ce40..c3e3b58fb86cd75e175b69ca45530610c500b99e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -401,12 +396,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -415,9 +404,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -585,12 +570,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -599,9 +578,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.43.0


