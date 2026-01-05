Return-Path: <dmaengine+bounces-8030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76729CF5118
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 18:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1FD31417AA
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93038335095;
	Mon,  5 Jan 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n50LAJmQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82563318140;
	Mon,  5 Jan 2026 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634980; cv=fail; b=lCP1mwm3Lnrwqpr6v8VH/BwG03P9GV8QUPEhyvrpwYsBEm3jEZRkjtEKhxixSuzMTYr8LbJqV3x7miQIbxUqWguboVclbsacoFe6dJZ/S0H05ynpKQbGye2rhVhK7EbSETYZd/yv0B4+VhcCsgGZmVfcW8rNKoxVJMqNmNt3t0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634980; c=relaxed/simple;
	bh=ZHruz+u0Mc3uKlgcwbYuBU8+R0G9aoX8gfms8oJP6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMnNjtUBfUtG1IybMFKeT3bfZMqRokC5wG8z7WVq3OPc/aUjhyEJsGDriXBkYhg2PpugzBefQxNkuaPTBB1GX3yFAOBd+hzZhKLKWISh+vI0FzoFamVIhh3KnQ3Ep0h3t0SZfisLrRRKyzErS4/wGGpixaW+P0S+AZr6nKs4mEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n50LAJmQ; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgUHWd9X96KG2cFWZh39agdSFJpMVwE8dBqFOKAC+osxFGj8OLpoOpbwe4G3IceNCQ0w9DadNoeCluiMf8E4mV0BEQ9ecWwMaqaKvue1edIOwvn1+h3pfbCcGZ31dhMn5RqLh3QrPjIgndadvnW/KBci6WXSN2Gyb8Eyc92LePlLAOdfjy58Y637PSHqICKabyjMvftBAanOxxi3/imhELbbojowKqCXgejvMTIXfgr683tQavWJ00sToDHp4CYZ5THI7QKyRCSinj3Lnb++d/HgxIMpXBAtD7A6f6S+lz/6eUtBzO0nhR7zqc8QT1Ax3Agg/3Yzdsb+8rmb+I7sMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoQBe2M1H7e+R6cv9OekXd21J6AYucHze87K0+LkKj4=;
 b=G9qoMWishT+NERaFVUXEPWUASweK0TFAI3dOsAhEsf5XH/2bxgTtNZeV3UFOTuHzK64K334IoH06H8N8k5nnqR2i5hHZ4016fpOOicBl6yzLZ/nppScOfkjFgpj5jWoG47hinGDfc+FaRCXRKq2iJeDG+73SKZo5KyXZnJRMblAy4GRzZ4uf2re4NIv/nH7jnGYkH/qY5mohAq5axMDtGxMi3brWTS9uV7mgRlxu3FUG//DKPkvpkiSec7IoKPE9lLsS3eA8E4ncsHlOU4H4RM9+z5IrilOX7kaFg/YLeWbD+TCFCN5VSxa18yNIA0OvAiLaWS7niM00p+mu1ZnMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoQBe2M1H7e+R6cv9OekXd21J6AYucHze87K0+LkKj4=;
 b=n50LAJmQpei1x+mmBsSVZizoJVa++VmX5jHKOOhK6n0hyMMsYIyM9JdL8+faS97VL5okLPGDWjfrvQqHNvIgOSjiGM6MmYQDtzSoyo/RLhIHpK1lHe/1Ay2IJMiGIYu2osFwgZaiy2cLXH2H3GKw7wHKFcifWOnYFmPnkMDzRU3p2logLIKGjvnaILurBcU/53lbZpbLXjSVsmjhCdByBPRySKuJxqD2BSlOcmO8Klk2kfE9HjoVeu9+ATawpUvC6LrW7t32/Cx3kpHTdizvIGt3Nqf8ZdwXjsdfxJsXLpT8tf8w9n8JD6WSVBh5/yt2W8Zkx1Tap2E5BLjEqGkDNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:42:55 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 17:42:55 +0000
Date: Mon, 5 Jan 2026 12:42:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <aVv4FpcvIKX1/fMO@lizhi-Precision-Tower-5810>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>
 <u5morpcx47pgyg7emt6yhhyivevwtbgvp7xme4uf6ssrcvew2n@yznzt7mj4ns3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u5morpcx47pgyg7emt6yhhyivevwtbgvp7xme4uf6ssrcvew2n@yznzt7mj4ns3>
X-ClientProxiedBy: PH8PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: b13c3164-414d-41b4-9367-08de4c81db54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHAvR1J2WW85a0JkVEszRU9sSitwekJ1aERTTUJtQVc0OGIzVTRENmxlQzlN?=
 =?utf-8?B?K2hQVGJVQ0hRVjhxYkRKSlFVSElMZ3RMNmEvR1NJTWJHanFDT1pweXhQbGh4?=
 =?utf-8?B?THZ1NGNTMUpXZjlqSDk3Y3NRRTVDbE0yREdlTUZWcWJQV0VUZUtvUW5hbWlN?=
 =?utf-8?B?MUtwMlY0Qjd0WGJVM2huODh3dTFhbm82cFhtbEhKdzlYZU9TT2tIWEZLdTEv?=
 =?utf-8?B?Z1F2VVdGa3BwNTQ1UHFIYnRnNzFZVU1hNTB0ajQ2VXBUVXFZYzNrK3hIakVW?=
 =?utf-8?B?bUthY2RGWmlIOEgvVTA1NnljR0o3bHlzaXREQlBVdDdmZE9xWU9pek1ORjlC?=
 =?utf-8?B?K1VsaU9rWU5zQTlKNllSbTZ3RWxBR2tTcHQ1VGhXT3JWakxrWnBFUXhONCtG?=
 =?utf-8?B?QVBpRVhIOVRSQ2NNQVVmc3dZVUNDUnd6UHpxakdwT0pVd2x1WW1uNUJsSmc5?=
 =?utf-8?B?NHREeXhNVnFvQktWWU02RzV2RnlLTTI2Y1ZDTGZWaFYzdEtMQTN5K1RnU3Vy?=
 =?utf-8?B?c2gyWFR3TUJkVVFmbGVUbVJXYWJYWm9yTDMvdzJCRkF3enV0YldzME9nYUtw?=
 =?utf-8?B?UXVURHJwZzl6MG1LSjNFRFFoNE0wZ3dXNGU0bzJzOFhMbkdlRGQzbElNUnNX?=
 =?utf-8?B?VzhQd2lVZVB3Y01XeHhKZWRSTCtsbTNYR1E1aHFhaUdFQ1V3Wm1TQ1dhd3p1?=
 =?utf-8?B?SVkyUDNYSGNpZWNZbGU2TmpXOThuTE9vZXlNcm1vRUFsMURWanFGMWxwRkFo?=
 =?utf-8?B?cHZxMThFM0VPbXBXLzFqbStXcXc4OTZISzhPMFVNYk02cjNXaGV3WFgxR2Jx?=
 =?utf-8?B?c2RZZjdCUmsvaTlXK2MrVzlVY2RiaXE5Nk9sbTdYYTdONkNSR3RuY2RaVjcy?=
 =?utf-8?B?SXJ5cWkrcnJhTjhrWVVkL20yRVRYOFVuSzlsRFY1bTlaNFNQbDVFRGtZUi9m?=
 =?utf-8?B?U3JiTThoeHdJNXI1b1NhWkJxdGhDZlpGcGxkUUNkNGFqVHdBclY4ZVJlRTJk?=
 =?utf-8?B?UGk2Yk5hL0lFeXdYbkJVays0bmZZaEc0eGEwV3J3ZDhYRDNYbktPZy9UdHhN?=
 =?utf-8?B?K0NTNU1TWGZJS2VaOXJLZTRNQUhGNGY0NGFLYW5RUStISEVzNVpzcnN3MWlR?=
 =?utf-8?B?SVFDSytvM0o4VWRSODREd1FudCs1cnhQbVl4dFMzRFo5V1AzbjR1WWNMN0pI?=
 =?utf-8?B?SElpWWIwK09jL3JhVVptUWZHTVFuS3NhY0gxM1Y3ZmF0S01QUU80aEhORDcx?=
 =?utf-8?B?TXZTYmJNWW9aNEU5NjF5OHlTVG82NEVLNDBZRHh0V3pOOHpqUEhzVllCMWdH?=
 =?utf-8?B?VDBCMGhML3QwVWl6S2tHRWxUWXNYcElET3VjTHEzLzRpM28wNVk4ZmNGZk8y?=
 =?utf-8?B?ZkYrZURzUHVwd0VyeCtBZHJVVDliSHN5UTBocTNFdnJETVV5bVJreTVGMU41?=
 =?utf-8?B?bnhFbER0aVZFZUE4L3FpdzBFNzNxL25HT3pQKy9vQ2dPV01WR3UrRmYraGUz?=
 =?utf-8?B?U1E2SE55ZXJ3S0tjSWlaZGJXSEZyMFRNSW1tUlMrU0N0L2lQZkdtUWlMZm8x?=
 =?utf-8?B?dlRFYU9uRlZVQ0YzaE1IMTRNNm1mVTE3YnErY2ZpekhhckpwNFBFVndUT2p5?=
 =?utf-8?B?dEVKSnlrQkd0WHE3ZFI3TFNtcjdLMDNSNEZLVVFUbC9kZWl4MHp5bW4wQWMr?=
 =?utf-8?B?a05vZkViejVTTngrak0wYysvZk1GOFhGbTJpWGQ0V0t1UzhlQnRhcUQvRncw?=
 =?utf-8?B?NFRuMld2UjFlVzFwR1kvN0ZBb3ljMkZHdzNvbTR1TkJFSjF4RWNwZ3NSQm1t?=
 =?utf-8?B?ODNDdFRmQ3g1aTFwVFYxWlA2QnNjTDR5OWo1aU5zSm14QUtGbUphS216NVdx?=
 =?utf-8?B?bStMZTNRL3JZY0lTblZQK1RYS25xdWFiVlhuZmxaeDhqcnlqSVBJbGVLbjFK?=
 =?utf-8?B?S3gwVWtJZExlbFVmdnM2MWVneFBBUmRJZTI5R0QwdURqbXg1WHdld1VpZ1A5?=
 =?utf-8?B?R3ZQRHdtdGxHV3RHaFk4VkVDS09jZ3RUM3NMRm40c3FCRUxrUXVUb2c4d21X?=
 =?utf-8?Q?patQAV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTUvQXkzWjhSYzFudk1BUVVoc0tpUTMzaHo2cTloaDg1Z0tjbWd2T1lFWDlr?=
 =?utf-8?B?b3p0TklRN0Z3KzAzdmYzNTJBK3FlSmtBSkg2V1RzSWtaRDFmYUwxVk1IbU84?=
 =?utf-8?B?bzBMQkdGZUhkNTQ3WFFQcUptMElEVFJyWG80cktENXFqa0I3clg3RVhYRXJz?=
 =?utf-8?B?VDgxYzMzWE0yTHZHcU9kalhicGk3cC83di9xZEpkakx4L1dLZzR2V21WcTh3?=
 =?utf-8?B?ejhMeWlRZXVKK2x2K09pTVd0QWRNOTdCZzE2Mlh4eWFsZEtTUWlNTy84K296?=
 =?utf-8?B?MEZ6S0M0c0Rka0FvWTh1TDVhUGRBVm5PaHNHK3ltTlU5Um54RTBpOWR3Qndl?=
 =?utf-8?B?K3RSeTF5ZG5zbnVoWGtoQW5QZ2krTmtTdmNSQ3JsVTN5MGgxR3hETUdpcjI5?=
 =?utf-8?B?S0c5dzJZMUFRRW15b1RXWkZ0b0pka2FoSElFQ3ZQcksweThsMHhVaGhJTUxs?=
 =?utf-8?B?NG9GdThYcVJWaldtb0VZUzZLVGJvMk5LN0pTOGoyR0Vva1dNcFpLc2pGZzNR?=
 =?utf-8?B?aFVGdHZFdzZudXFORkVqM0V5dXdPL1F5N1pydWdra0Ezb1laRzlkN3Z5L1NS?=
 =?utf-8?B?dTRRUkxZYTZON2hseXc4aEk4UGJOV24wVGNUY01WVXNnUmg5ZHRQSGd6Ykkr?=
 =?utf-8?B?YzM0ck14a25NL1czWm16VFFuNGIzc1hsTVB6ZXJISkRxNjZLOEFTeHdaUys5?=
 =?utf-8?B?YzZ2aTFCQkFZMzllMzUxOWpIbkxkVlFIYzdkbjN1VWlwblZRVWF1S1Zlb1ph?=
 =?utf-8?B?YjMxNmVwNFVVbHY5WUw4UTRmaTM2UG1GMTBhNmlTZ3RTbkJnVWg0Qk44d2ZM?=
 =?utf-8?B?Ri9SRlFReXYwMkpxUFpFL2RuY3cxSlBYR1ZyYnEwdWlEcEtrb1V6NHVPM0tT?=
 =?utf-8?B?cnFXWEd0dHV6ZDdvZFQrUEVNNjFFVFBRV3UvT3Y2L0VoRG50RWdUbkRLUEFv?=
 =?utf-8?B?SmI2NXN1NkcwUlhKNjZlMXRNK0JaVEVlTkJsNlduV1J6ekd6QkR4MFgySTRn?=
 =?utf-8?B?SDJpcW9LR3hSOVBVWWozMW11MTJkZHZnb0NwS2w2bjlET0c3RHBwbjFlV0xH?=
 =?utf-8?B?NkJBdGtYRm12UkcwY3duWmhPRnl1dmliazd4VEk5aEM4dUtqbmIrZ0dkK1Fh?=
 =?utf-8?B?TnVUV2N3SjlpOGRNNldaTHdSYWFrQTcrRHRWMWVybDY2WFZuNzMwU3hwRkY0?=
 =?utf-8?B?Y0dkUDdwR2N1K3NtVk5reHJDc2hoUnlrWjBuVWJwb2syRVBvWEFBUllFUWJy?=
 =?utf-8?B?ZDVSVkZQNTUzQ05pM2tRQmpOVjRjTkpMUTRaNm83ZXF6S3FyWVROanhmRzFy?=
 =?utf-8?B?R0xZOGw5OTZNOWtockNmVWhFWVZxREg1UFVKQ1pRbDZGVmFTaktLcVBoc3c3?=
 =?utf-8?B?NnpBeWlnRzQwSFFtN1hCaUVYelkvcTh0dEFlWmRjOFVHZmFWc1B5S2tSMW10?=
 =?utf-8?B?YzVCWGxHUDNYdXo2SWtHR3dRSGtMQ3hDbFhKNnBFdjYzNlF6WVB6bDRIbXNJ?=
 =?utf-8?B?b0RMT0VXNHViY2wzS1hxeUY5TlZxRWcwdHIrT0pQWkFMalNkZ0JjY0ZFbXNP?=
 =?utf-8?B?cjJSaXp0c0QwRHRLMHdObjhndHhhcVFwSllGNi9OQTJZUGNlZWNpNEppc25w?=
 =?utf-8?B?US9NYm5xRUloNzc0ZEJROVNSUmhBbFJqcXpvWXNjcDV1WkJxcUtUVEJCM2U4?=
 =?utf-8?B?ZG0rQi9tS3BTRzFMNUVwK3hEajA0bVB4bVpsU25tRnBpWUlmbmNHRFRSdW9R?=
 =?utf-8?B?SFlCNHRRcmJiZmQ5djB5Qi9IaVAvdGZwQ3lHUnJOMmM2WnU5Ly92dGxROWdB?=
 =?utf-8?B?NU81QS9uL3NKRDJsZUZoQm44b1hpYjNuaHNYYitJOHpGdkRzRHhqK290ZWhG?=
 =?utf-8?B?bFVlUUVhUlZwMllaMEFkdzJIQ0x3Vkl6b2x5cjRMZlpocjU0VlVkKzJrS3N6?=
 =?utf-8?B?ZVNuMEFWaHdCVmYrc3JyOStUNHA0VGNjLy80STlRSFQwWGF1UXhhRFp3OFk4?=
 =?utf-8?B?ck03UzJsQWtYbSs3RHdOdUx2Ymo3dnVjMmhVUzdzdFBZelBIamw4SjNXdlBj?=
 =?utf-8?B?SER4THFkT1NFWFhZdFB5amZjRlZSZGh1WkxMRmhTYytWK2RaMktEWHBDUElW?=
 =?utf-8?B?Q2o0TmhnR2xtYzNJOUZSZzVDRjd0Rm9FVDh3VFNaTUtTeHU1YUVkSWVSTFll?=
 =?utf-8?B?UzE3QWpHOUlGSHc1NDBGcUJCMzVUdGd3Q201aGw1ZnhSb3pOdVBKZFR5a3V6?=
 =?utf-8?B?cFlpRnpnVUhkUU1jVzB3Ym53VVIyM1licXdGdW90VEVsRFBJVzRVQzRyM3RI?=
 =?utf-8?Q?sb87klw2iEVqJ80w6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c3164-414d-41b4-9367-08de4c81db54
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 17:42:54.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWi/qhz7x7Y1af0wHJljJSyUjRX537IkbcoY/H/c8vuw0+WPQwo4rQey+Y5N+D7LGqLcwf7o6hTiFAzgIejc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

On Tue, Dec 30, 2025 at 10:00:49PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 12, 2025 at 05:24:40PM -0500, Frank Li wrote:
> > The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> > channels, and modifying them requires a read-modify-write sequence.
> > Because this operation is not atomic, concurrent calls to
> > dw_edma_v0_core_start() can introduce race conditions if two channels
> > update these registers simultaneously.
> >
> > Add a spinlock to serialize access to these registers and prevent race
> > conditions.
> >
>
> dw_edma_v0_core_start() is called by dw_edma_start_transfer() in 3 places, and
> protected by 'chan->vc.lock' in 2 places. Only in dw_edma_device_resume(), it is
> not protected. Don't you need to protect it instead?

I think it should protect by chan->vc.lock in case consumer equeue dma
request. Currently, there are not devlink between between consumer and
provider, so consumer driver may resume earily or the same time as dma
providor.

But it should be seperate problem with this one. This one is triggerred
if two channel equeue dma request at the same time at run time.

Frank
>
> - Mani
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> >  	struct dw_edma *dw = chan->dw;
> > +	unsigned long flags;
> >  	u32 tmp;
> >
> >  	dw_edma_v0_core_write_chunk(chunk);
> > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			}
> >  		}
> >  		/* Interrupt unmask - done, abort */
> > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > +
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > +
> > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > +
> >  		/* Channel control */
> >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

