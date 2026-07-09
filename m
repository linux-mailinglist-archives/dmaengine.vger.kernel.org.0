Return-Path: <dmaengine+bounces-12238-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wZ0mBbnAT2pwnwIAu9opvQ
	(envelope-from <dmaengine+bounces-12238-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:39:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350E733065
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:39:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=kx1hS6jq;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12238-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12238-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8938F3009CD4
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A657403AF1;
	Thu,  9 Jul 2026 15:33:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E436CDF3;
	Thu,  9 Jul 2026 15:33:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611225; cv=fail; b=ncM/eF+Ym0ReyHExna8YxetCEcbpxdOGY9XcOfbyDeyJZP16tV/udYMjczAnZxh7yDKaV/JKAqffi/eydZ1smQzQKOulevPP453++28Ia/CouRNoKS8AlHOt5Y0LE3RVUajTOL0cR6Rlm/gkyYSj2dAQr8fwDy/4F+roSVQimLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611225; c=relaxed/simple;
	bh=0XK618ST1cu8mcAjZEcAcAttaixSifeH7PtCQEMfRUk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sGYhye2155Rm7dVSHiIbsWCvPQLAbbLoXpWh9Chh4Z/n8EIZ6W9juO+bg3h6H+L71KpAQgJA4MoNeBy0ifHU9gdK9svNH9TqXc8pZkrEzAlbHZggbJpEmbV3bZSIkgAnW1FTsQuJJHRjwqv8gr9qMBws/uG1896+MiIlgtzO5Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kx1hS6jq; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpNDQIMiwpg2obQu0HWJgl00wa8lxa6/yJehRMXOcQxvIH4dWZ47WzuISw+ha6T/V0+4Ijpeo1CzHNHWIetYkNBungomCPeZLY2Kx0RthvJ56R0hCFvRH3vmkiMr0G7qSeEzOMLetfCC0RSLCH+OYkZ4Tw9J0EHeThwps1s3opYjkynW4o/hw0ZTUjd15/fWCWyikA6eVxEMD0b7c0Rw7xDyk6rSr6VJV16AGbpIwIlOp0o79Y6vdxYx32uAlIyxI+gEWee0pJad2tbzGUR74K/DZsP3DYDpQzPFwk2ZsTkcHtq4stgHdybxy0CwG9X2gx+sNdzj60cIj+tD9U0CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv+nEDhF+OVqfOGl0iATc5AFyFzhgGxkEjWmX35k3tk=;
 b=eru0SEtTtao883eiHdSKJD4fzXZOuD+N10sLrIJH7NmcEd+v2D5VnlqFjc9xleJenKNfTxWguUUvHX4kzyLEem8SEcL1bSFnEkU7OLknDeL1XkD8CBcy4pOokiUuPMR4O54ZicjnWHCS7A3s5iAFz9MW2+xIbu9NhnfpX+yBsAErm4Rjq99hdFiWfz7CW1/igIrAK8TjkwZtZb/Ozxm2yNhSDPaQ/8RARj2NuHxJuGyXRIvEvPuepIKzlttaNQEfHjSAySP+TQfx9nAVQoXqVLJekmx1PR1g9xQDEbPrIQDiIfecdwODKBQq5JZC8BWq+9dyWwdzxfgMo//9RdPZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv+nEDhF+OVqfOGl0iATc5AFyFzhgGxkEjWmX35k3tk=;
 b=kx1hS6jqtWmQdHZdJqEOSmYk/dm2HyJqrXj7Bgb5PBiF8N023tu4BSYoQINyN0rR+dGE5WwdvewrBLIJ62qpFPeJFa+mX/LDSVCobiEiV6kQQZNG7H4IgmByOVv0+GQibb39gxpK9d4FFxJKXCxkg/f1ueYuCw78w+pqjPkxfZhLD/SXSD5Y8+joR5WukMNufgufpdqp+FPmb+/RZbqdHiZwcpqqIAt6IsctbL0Pn7N6eRp8Ud18mH7+5bTkh6t9x4zLxLMFaT4RMrr1pevHmEhGbPC3mqoRP89yn+KFQ20vi/G3TEFVzrrpVPuiB40jjf5//aSJVjQdF4b9PE0JcA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:33:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:37 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v5 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
Date: Thu, 09 Jul 2026 11:33:29 -0400
Message-Id: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEm/T2oC/1XNQQrCMBCF4atI1kZmJmmSuvIeIpJOEw1oK60Up
 fTupoJWl2/I92cUfehS6MV2NYouDKlPbZNHsV4JPvvmFGSq8xYEVCAhylBf/fFykVCCrjy4MgK
 K/PrWhZge79L+kPc59fe2e77DA87XT4O+jQElyMjOqLqMBXu1ax63DbdXMRcG+igDCOWiKKuCo
 SJbERuj/5ValIWfv1RWzlrvtVFWA/8r/avconRWzEgugo+VwUVN0/QCnqXh2T4BAAA=
X-Change-ID: 20251211-edma_ll-0904ba089f01
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=6631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0XK618ST1cu8mcAjZEcAcAttaixSifeH7PtCQEMfRUk=;
 b=7FRRcbn2A3WwoRvMZ8wmTuyJceLFfEXn2YwlGw6JP2g4l8oJ5OTyDJdf8p1vVNDblXw3PjlkF
 OLbT6zA2GERCvKsYjgjHc5OME3mP400u0BQa3m5gzxGlCUXG9mgsl0u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0066.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: ea930080-3eed-4ee6-16a7-08deddcf7223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	N3uABp+mvk+km1QZzwlhW2HmznOU/GgObeYHEovi+25kqtdUgLgxNQnYDF4pLOTWyeST+fTY+zNCkZKjTH0P2+9NmWJ0vnVqWcwPUL7BYh7DyXJJgHHeYxn2Z01iWFSjwldhsc0/8uj6sjvG0J635E9u8dlZir65W5GQsQh16645NWtIHFcay/NjMqsiU3RT9R18u0CG4phiyRyZe6dyqjnjMj/XYAZmUicgNsfK6odrjPX+ZDnjaVNQ4L3IkMO82bFNMnfbfO0eWiEzxwcqiFqbinYsyj57s5Ww0VnLhXeHbymHPi9CHcmxYo7+IUtpKTPYbDxisNZHLoFgABtnalrk9GAiHYDcc9VXzapTuv/gqaA3PHfUWgFjS+YB7ZoJtpoilXSV0CSe+Q/ziGiRGeVaAAhBZDktHFJQoD08MTWbZCXw69gDx6FSe8H8wOATsIKWCVCWmFbu+bQ2Y1AQvzwMko8/Vf1ND/bHv0ByHo5Q5GWZgG0wfZPpJpE27l0XHR7DUorvIawZ1zIq9tSPcpVXP6r8hG3uwLU5phpYvVtkL1sAtGyaP8ZL796AOc2xnZGE0Q5GtRX0RVF32D1l6DyHs1RNtkUIPccY6zHxa+rHkSTULhFmT22n7bR9IzkInDOTL3jZ30TWI/JjTN+5QPgNrP9XA4eauEu4J7iiCfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTNQanNzOXU1VEp3VTJNSWRYQm9IejUzU3YyZWo2cXBTQmlJU1AyUnVjMUVi?=
 =?utf-8?B?VVU4WmVOZCtPNjVFU0h3TnBJWEI0ZitvQkcvc1VlcERkeXd4dU04RU1Wbkdl?=
 =?utf-8?B?STMzYndHbGtMOWJ5UkIzTmtCUXU0TGQ4MytYZDZkVk9EbjRGaFNML1UwaHUz?=
 =?utf-8?B?ZjNrMzRtc2diMi9UZHR1ejBGSmpMd3YvZVRuOW9sWUYrK2lyakZzZlhEbE55?=
 =?utf-8?B?SC9tQ09acXBaVmRlVFcrbUhXdktnS0VkQjB6TDVjK0RqcVpDUlE3TkNoRkdM?=
 =?utf-8?B?N1RqWkxEaVNlUDdIMU1ZaWZiZ3lBRGdFM3VYUkdEOTEyV3BiVTl2WGxvNDVn?=
 =?utf-8?B?a1BXNUlmcGRkamZmYStIQngyR2xKVGVRMFZUS2hNYmNEcVMxTEsyZlBaM2lr?=
 =?utf-8?B?Wk5UdS9OYlpOSG9WQ2h3QU9zZGtvd3c3SXBPZXhBK2tpMUV3WDBwbVhEVnFQ?=
 =?utf-8?B?U3ZDL3Y1QlV1M0JRdEdVbzRDNzNrY0JCRFY0UTVpL1JvRTRHeDR6azBmK0sr?=
 =?utf-8?B?U1U3T1Rvb0krVzhjRGRNYjJqTlordEwreWNCUTdHVC9tQS84TDVXOGI0bjg4?=
 =?utf-8?B?REZWZDBtWXZ0d2IybURpalVHbWIwdERUSTlleFB0RGkrRk83anl0cGZiU1FN?=
 =?utf-8?B?NjEwOG5MVnRkRDM3MzhIdE9SbkR2TXpDUXhHNWlVNEdtdUsyRG0xTHp6OGlI?=
 =?utf-8?B?eGdLd0FXTXd5TUc0OThNd0YyUnZrbXBtaGtHMWt6Ti9qV1Y5ZW40VWtVTUxw?=
 =?utf-8?B?eUc2eVdYa2ZmNVFtV3ZRMzZFVGl6Nm0rOGQxOTdxMmRBOVl6NXRXckdaNHdk?=
 =?utf-8?B?bnQ1eUFLZ29oNE05UGRVZmhha1U4a2Y3ZFRaaGp5amtXYVFqcnc4QnkyNEkx?=
 =?utf-8?B?NVJCY3c2ZFR0ZFF5L0NDc204anNjTjdiRXlQMTA5VUZnUG9nT2FiY2hpdmor?=
 =?utf-8?B?Slh2RDlLMllkUExyMmlveFRPSW5EMm5zM3VoVGZwYlhMeDFCUitkdUxrUGUy?=
 =?utf-8?B?azI5Zm1jdXhYTDdmeXNVWjZoeEV3SExUVFNCWGNHTi9RS3dTMDl5eUVsVjd3?=
 =?utf-8?B?TUg1amZET2MrMWJWWnhIby9FcVAxa01XWVZrRm8xVkd1dWxjdDdPbk1IWVkv?=
 =?utf-8?B?YVVkeEhLejVqdDFHMk05REdnelZMbWVPckNRc21JRlFMNlFZbW9GUW1UdXpT?=
 =?utf-8?B?R2ZvVG9vSGRhYkpRd3R4ZzEzZ3luOER3bjh2Nko2cmJENXVMbE13NHhzNkw3?=
 =?utf-8?B?eGEzakpXMlpZdUlYT0RKWU1JaEE4NWE4Z1k4c3FSM3Bvek01bnlUUnErbGZV?=
 =?utf-8?B?RWV6eWFVOWx4b1BHU3dkd3lld3QxTm50Nm9HMDhRanRXcTB0ZThDSys2K1Fn?=
 =?utf-8?B?eTBTcllIa0xCTUpyOGE1NFlWTi82ZExHN05rbnBKU0tQK0FibDA0ejZ6S2NX?=
 =?utf-8?B?M1kxZENHQUNqUHN0YWpEc2grTW13K2RUdDZJaVl1SG0rREZ2SmJ1bksxOS9r?=
 =?utf-8?B?QVRCV2pKYzlaVUM5K2VhU0U3K1AzOUp6dGZzd1g1YXVXNEJaWW5jOWRTdmFw?=
 =?utf-8?B?VzByZGp6U0FGcm5TZlluR3NtdDIrc3V5N0JVckxIT1hCTHkrbUl6MkpyLzhJ?=
 =?utf-8?B?WkVycEUyeWhaTjlkS0tZaHhGVHlIU3F4T1gwZHR0R0xYMjFUUmx1dUl3UUVt?=
 =?utf-8?B?Sk1mSTFpK21ud1pFN0VWbkpTNFU2ekpBTzVPajY4MTA5aGdHTVRDdzRWa1pP?=
 =?utf-8?B?T3VQWW16QlVJaDB3ekJFbmt4U3BWTVB6cDNXVHRtRXBBODBSa0hpY0pMTGlD?=
 =?utf-8?B?MnJGdXo1NVdDcFExbW9wb3IxQlpqU1U4MFRVK2RZa29FTWRuKzJLNnZEdWs2?=
 =?utf-8?B?RzlQZkFYRmx3OHZQR3laUkNGTnZyMUVUWVcvMlNoMUt5TWhOWXh0SzU4Tmo2?=
 =?utf-8?B?OVQzWVVVdCtDc2d0c29uMEZoOXhkbTZnaWtjenBWNWp4NFZXRGpJNUNyZDk4?=
 =?utf-8?B?LzR3eXZNWG11MEE3REZnTW50VzUzQTByZDk4Ykx4NEd3OVJ4ZHZzL0NiVzRY?=
 =?utf-8?B?SWd4QzUvenRJTlJoN29uUTkvbnFua1hJdWR6N0tqM1U4R25ySGszMjM2S0sy?=
 =?utf-8?B?TDdXT3lwN2ZGbkt0SnNRU05PNy96b016bkZVUHpUa0ZESDZoOXFzRHBENU5B?=
 =?utf-8?B?RmdOZ2JvMlJ5eWQxU2YyNlJuTk9WREtLTHFJTGdWZ28yTzdjcjZYNDg1M0d3?=
 =?utf-8?B?bWhGYW5rQVY2ZDBOT0VyYVBWR05BQ2VDR0RYZzdVSFNGKzVXNHYzK3J0UHh3?=
 =?utf-8?B?UW1JZlptbjhUcVpNRjRVOS9ibEJJOHl0SEhzZkYxZGNnZkMxMmt0dzBiNkNQ?=
 =?utf-8?Q?EQluFIBoUrJ/1L7egzLiiNuGA3q7l0WJzATLJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea930080-3eed-4ee6-16a7-08deddcf7223
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:37.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GrNCZNv24E7cpxS6rGOk8E2jYjCPgVR5150nJkrjpt0y4J2cULOqfhpCTlq8vueKp+jnZzFDqVivobMJNrnAzE7Cl/5oEh4LmqBhUAxAFo6Q1MUEozpcs9bVzTN4Tm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12238-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,msgid.link:url,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5350E733065

Verma, Devendra:
	Can you help check if block non-ll mode?

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

Flatten desc structions and simplify code.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

performance is little bit better. Use NVME as EP function

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
  IOPS=261, BW=132MiB/s (138MB/s

After
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Fix cover letter typo
- Fix double subtract found by sashiko AI
- Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com

Changes in v4:
- collect Koichiro Den test by tags
- use addr in argument when set ll address, found by sashiko
- fix iterate burst problem when exceed max link list, found by sashiko
- Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com

Changes in v3:
- remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
- rebase to vnod's dmaengine topic/config_prep_api
- Add non-ll-start() callback to handle non-ll mode transfer
- Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com

Changes in v2:
- use 'eDMA' and 'HDMA' at commit message
- remove debug code.
- keep 'inline' to avoid build warning
- Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com

---
Frank Li (10):
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add callbacks to fill link list entries
      dmaengine: dw-edma: Add non_ll_start() callback
      dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 218 ++++++++----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
 4 files changed, 304 insertions(+), 388 deletions(-)
---
base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


