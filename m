Return-Path: <dmaengine+bounces-10370-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMLnMF9bA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10370-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:54:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E7525342
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F06BC3099431
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833EF3D1AB7;
	Tue, 12 May 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="csbAVl4Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437C3C37A3;
	Tue, 12 May 2026 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604147; cv=fail; b=XOWK+s2qT28FUeougpXpjEcfK5PfbtjiMhDo1SzXfitVHtWKeknxylHvpB+iXK98/U/fW7ddGupYLvZT7q4BLFjg4p0Xh6XQoBZTeDdpCbtU3Z5U0YndV8ypsAQOXHQOONFOZpFaBT/FkX0BdmmSodVEXYM60EpxqaqssFVKG9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604147; c=relaxed/simple;
	bh=wlLaLjwVm8P+teLdMlCHZUiTw4NrLDFUxmwHVL51UZY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WUDSh8M/ypVSv6DdMDmRtsBY7HI/nw11Wc4XKfh0dbj3/zpgqnxEdThrB2IUGPuSXN0A2xgfgxs1ioB6JCsfvZW3HpiP5s11avUVfsrdvSvMOvCNJCwQescC+YznPPWYCf6wnNO937ZimKT0MAtcThndUs6RxE6XhMnEn1bkO2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=csbAVl4Z; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSJBTZ3E6VXbaV1j0crVQxeRbIXVVgpepYBhEz72ykZlebCZWo7xSrFuqEKnC8voatGit95kjve3zJscih2ADsnJaWQF+jWpiE2ea6S09m0yvw4IgXW5M9+iAFnB0iOlDSRr7U1D7LzK/1EiBrzyLzB/K3WQeMejsVi7/o9fe+I3I0vBEK6gubluQAh2Lki6v25LI7lTwZZuPGCQjW2OAond88lLNgl97BWG6MwS15Yqy5W5yrb4wXzCcfdE6z98yZ89kwwOth+omec0fHWQAJtz8kK2m6urcmM8HwJlL6Kot2MR/VmeopllgBj1dI+R8EM+jS+GnEMN6QGoyhg9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq2h5RM1/L8vFedoB8rsrQMwm66AH3QbzYks3ONAKUs=;
 b=nBPam9nm5q0uYZtOFaddI+4/Mq6+5DWYg8c5jUpiXyVohmv5ow3t/SB9MHSfKJKk13fRaUbjrC4gZKLd/gOq5wQLcEVM2uO6gxZA3Ja6qQeGWF65MWOoaQIbSEZNmyiIGwDaX08k6vu+Kzhw/VyaA1QBgwz9shrPxH1TFu70201GocBgANtObRXNCZG6A9IDN7tm8+hxadaPWOHQ2VP72+9DVqB52fG3qcm6RY44eXATdDLJ3/Y/WdKt0yK7YAJ8eHZ/eFEICLtjWHi1M0aE3c5GfUl7YnwgZG5OQJGCO4oj73gPA8llCV/gFZ2+gPYWiF20493AvA7m4o8x9DTwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq2h5RM1/L8vFedoB8rsrQMwm66AH3QbzYks3ONAKUs=;
 b=csbAVl4Za/16z4Rb8Cl1pUfo7UeyVAsOOgHmaA2TA2l8JwX9XnQRIsuITJ928BpiLHHsVjn+hbG3sCg9S3W06mAXuBT/epoQkxO25pcSWxtU2JQltfQzplx6mHgUFtwgD+KQlAY05VzTlMJTHWJ3Qp1yQfdvgyIUjIlvQZKxCoum+drtiIjnI2VkHZbgvR4eM0gnxp3ZLjEXjOvBkcZyBcYMG98jQ2nKCBy+UnvEkcIVH0DmOztycTdk6J3oeNZzN7F1zoyoKtw41sBpCJ/GRXsUkjRFmgjkFxBNG1+56minZai6fWP5kfZ0eDij7VWdSM6zbtnVrS+lHZA3sg9veQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:42:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Tue, 12 May 2026 12:41:58 -0400
Message-Id: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZYA2oC/23NTQrCMBCG4auUrI1MJpk0uvIeIpLmp2ZhW1opl
 dK7GwVRqctvwvNmZkPoUxjYvphZH8Y0pLbJgzYFcxfb1IEnnzdDQBIIivurPXd96M6ubWKquSY
 lSvCoyCLLKr/FNL2Kx1PelzTc2v7++mAUz+u7ZVatUXDgJNUOHAUR0B6aqdu69sqepRG/tPijM
 WsHJZQ7I7VA86vlW2sQQGsts7ZGGZAao1f4q9VHE+i1VlkbqqRHrGwV40cvy/IAu7Sb7GYBAAA
 =
X-Change-ID: 20251204-dma_prep_config-654170d245a2
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=3320;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wlLaLjwVm8P+teLdMlCHZUiTw4NrLDFUxmwHVL51UZY=;
 b=sBczamGhvm6KDIBZvI8uIuZCeJ/4/uMU70wyXArZpcG/SfFTZstwYagyDXZXCCxUB169wGBKE
 GLaaMjykVP4CK0iUNzt4bdhLKEtLoSLmv3n95/yGQ7Qr8aekwpZNmsZ
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5403a4cd-7d04-47be-d7e5-08deb0457043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|11063799003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6J9ZSDuIWfhNRDz102kwKa+Y3USH5Sfo8aRPZlOxSxzARSp2R/JP4XgYUKIcYTxOOJPDqINO15t6jjL7VkBnwvoeXpSLa2mgZB7CA/Zx/EsVcJz37G9iZ8wL+uHNH4ooaw9CXrCK4C1lnYrndGoRujrwIV9pI25RZlYFGaFuMcisIk8PXEtfv+kM6thuxAs4XqOw6Aq5ev4k6+cTZncgFGZjlPyPU4lwbXNmaW/CMnC/UgHSvMIaCRggkA76S2RS7J0LxmiZSDYUshqzevskqNc8QTKrGKUXK/4I3vrv4zS4B9h2OdN4muBiBZrYwFB7VtpbRmSK/JqB5L9ga6K1OhkZshlUMiJag/rZxRis8UwXmtI2cUrcw1NkZDN41+4OhNVzYiVN393m0RArYxp7xw7SxBBkccWR8ln8jFGBz69dfwzxSAxsFVavohlIsM/SJ/XLeXxYgJ2tILHR0uU0/lssDlnpJnPU2ac5bWjgJcras1owodtERCO+MI7qFTD/y/5nkA/4F6I3S7h6iE1e0eZ+hbAJ64zVLkPcdfQDAY4t0I0jdCIfIlEPBngyCc9bFCkDhFcPfghyRUaq77lGfydTXV/x6nXOFD/26QwV5HWces9mvkJh6bJDOziX7sKuPGuH13iE+bpLknVlsytoVhg5LNC7Ilj3v+abGNDisr0Ca42sJA2oItgBD9i8CmLAlGaNYRUjYtMuXlrncRQExciJZNGJH0/I6dG/c6zLEKVbmEWFUG46pN1cgjsFqzvfVjJKT5gsaXu6gbgt0kN+Dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjV3MG1aYWhXbTJyVERMTHgrbVRSdHZqbW54dU5PenpmZmNaZG5lNXlTaUZ0?=
 =?utf-8?B?VGFHWmxnSXMrQ1dRNFppdCs2TTJCekZpT3hSNGVhaGVmdzVkRS93NjVMcXor?=
 =?utf-8?B?WWgrR3ovNlAxd01mYldTTTU2clVzdnhuN3FkTmMxZndvZDhVbk9ZRk1LZ1E2?=
 =?utf-8?B?aFVjREp1Vng0bzVmdWwxUjhBUTBPbGhaeW9WeGoyWE93cWJDRWV5TThYVDFY?=
 =?utf-8?B?eHNmYjZZOUNwRWE3ZkpjRDkzMHRQYVZ3UUNGMWFZUnF5Q2YwVkV1ZTVKaGRt?=
 =?utf-8?B?OWtOSWdXTVhBKzFSSFUvNWxKTnhCRHJ0VENYTmFJTjh4azhFLzZyd1JpT2to?=
 =?utf-8?B?UFIxQWsvczkrRFJhSGJPVEJFUXZYSmwrTmNCaExIcTI2TzgxMlRna2tpZ3Ix?=
 =?utf-8?B?dk1IbVFvMDQ2QWxKbkUvZVo1WFRYYit5ekQ5UjkyTWZ6WnVGNTVLZlhzKyts?=
 =?utf-8?B?WTVhemVLdHY0VjQ0QVFUWUM1TUZWa2Q4dEplZFFmclAzWlFsOU9iMGp6VFZp?=
 =?utf-8?B?OUd3TUNtbzN5ZlhHR3ZpUzZFTVFpdkp0Unlwa0djZVMwM3pkZWY2b0U4YWpR?=
 =?utf-8?B?WXJuQlVIQkpobnJ4WW9wNE02QUhXUmx6YXdaY2c3elRYMHVUQ05CYlRKSkJL?=
 =?utf-8?B?T1NWMm55ZE5RKytFNHhzR2E1RTFBUjc1dlBHZmNTVUU5ZWlxb01zRHdnRnUy?=
 =?utf-8?B?Y0JML3IxQlFMSll6ZHpXOTYzOGk0eVQ3VERMRXVpSjFlcUt3TFV6a3I0Mk9t?=
 =?utf-8?B?bzRpT0MrSFY3TEhESWRrdmpick8raEFqNUhyQUZLWDI2RFNYbWpHTjhlNndj?=
 =?utf-8?B?SjhKbFBrUU1aU251NW9JQlVlbGJSaWlyNWN3RGthWHk0TDZRbjBJMXZ2QW5z?=
 =?utf-8?B?NjdWTHhxZEpjWkcxYUdDeDFUakZ5YjFuZWUxdmVRUlVBT0cwaVdFYm1teDhX?=
 =?utf-8?B?WTRIUHVqZm01SUdEa1M5RGJVbEN4VFpDSmhPRmVvRTBISXU3OGwyWEMrb21u?=
 =?utf-8?B?dzVTUjB4OFBGenRWZ0ZNNkp0UUtkV1RwL3ZwOEg0dThzVFFYM1gvMVlXOFIw?=
 =?utf-8?B?dklLWDRLSStJM2xGa0tzaXZkS0IxKzRIQnB2MS9YZVZwaGlPb0JxQ2thQzRE?=
 =?utf-8?B?Rzl3aExJamoyQkFuZjY5b1llUEE0emFhbFJsalprVVcrRStJVDFNU3EvSFB3?=
 =?utf-8?B?ejhRbk9iL0t4Q3BoYzdWWThlU2RuR2Z5K1ZRdkE4RGlJQmZDejhMREpXWmlM?=
 =?utf-8?B?R2R0ak1SWXVEcXk2dTFZRElTcm5qV0luR1l4SlZMYlhqa1I2azZZR1FLaUl3?=
 =?utf-8?B?M3ptTVFoYjd6UDdZNGRBSjFZZjJ3UDYyL3RpbExkd2J5ekJpalFlY2lMYUxK?=
 =?utf-8?B?WExDc3RoaDNOYjFJWFNqbVYxTGRGc3pLTVRGNmIrYVdrNjY3T0NCamhiZ3lR?=
 =?utf-8?B?MXpuaXdaVWx1b3pMRkkwSzFSeHZqTk94U3BQZzBZT3owTmdEc0RkaDF6ditI?=
 =?utf-8?B?L3R0b2lOd0VXSldlTkRIblN0K203eWxCa0Q5bjlRYXlHM0ZpN3ZUNC9KdVpi?=
 =?utf-8?B?Y3VUQjJVZGxydVd0WEZZbHMzRGF2R2hrUVVTZzNVY21RSW5ER09Ba0tVRkpr?=
 =?utf-8?B?WWhOUG1SS1piOXVlclRrdFFlVTJPQWVjZDNVcGdkeWJwOFhWK3VDb05MWXlB?=
 =?utf-8?B?WHgvTnp2c2pDVUl5L1RSYk9XY2xKekNUMWdnRW5KQlAvUjArZlVXR283Z093?=
 =?utf-8?B?UnJNWlRIVlg0Wm82YytBeVRkRm9Va3llVlhlTDJSYUpqd3BlMUtFVW5weEtq?=
 =?utf-8?B?UzB6TFVwbk1aMHUzME5BV3B5Nmd0bDFoOWw5ZWRzakdCSDJDcHdxcTNZZHZa?=
 =?utf-8?B?V20yWlZ6SytVRkJTRlRmK0xxMWN1SHNkWmdJM3FXUGdWanp5S2RjOHN4YWgy?=
 =?utf-8?B?RitSRFdZNkNhUG5LMEhNbHhLaVZTVkhQQkkzWWtCZHVJSlZqejhyZTZRSzdB?=
 =?utf-8?B?YXJyNTFEcDZ4bVZGcmhCS0JYd1NQV3NzdzNMVytrUEtaOEx6Z0I2V1VLYStz?=
 =?utf-8?B?MVdaS1M1RmJYR3EvR3QvaVBTa1ZldE1iU1o2c3pOai9Zck4wcmRDNFNpVlRV?=
 =?utf-8?B?QW44V0tZNUJyZmdOcVU0QStQdmdMeTFpZmFHaCtpN0xoY2E1S2hwOE1XSnZS?=
 =?utf-8?B?OHdqMVJEMzliS25Cbi95RjFlNzF5OTk1bEFOVHpsUWhoaUk0T3VhaGpRSHdB?=
 =?utf-8?B?MS82ZTgzcjZxdWZ2S3hoYWJ2UnlCbUdUMjFsZlVrNWtFanhKZDBMNEZMNmty?=
 =?utf-8?B?aitrZXU1OTZXblJuWlp3WTNZdTlYajBPS0Fydks1dzM5Q3kzZDZJUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5403a4cd-7d04-47be-d7e5-08deb0457043
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:21.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7aS6GjOkDyip/8A9OMmMWZEyOWkH1jyPJWlVGmyLtYCZpkywZcyqmqBrGAmrpFzcr+/B7SvU0+4LHF4DiTAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-Rspamd-Queue-Id: 117E7525342
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10370-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- collect Mani's reviewed-by tags
- use kernel doc for new APIs.
- Link to v4: https://lore.kernel.org/r/20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com

Changes in v4:
- remove void* context in config_prep() callback
- use spin lock to protect config() and prep().
- Link to v3: https://lore.kernel.org/r/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com

Changes in v3:
- collect review tags
- create safe version in framework
- Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com

Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (9):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      dmaengine: Add safe API to combine configuration and preparation
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_single() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +-
 drivers/dma/dmaengine.c                       |   2 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 +++++--
 drivers/nvme/target/pci-epf.c                 |  21 +---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 +++------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 148 ++++++++++++++++++++++++--
 8 files changed, 207 insertions(+), 84 deletions(-)
---
base-commit: b9303e6bff706758c167af686b5315ad00233bf8
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


