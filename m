Return-Path: <dmaengine+bounces-8155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E8D0AEB6
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 576DC308636B
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49E363C57;
	Fri,  9 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hIO13B6V"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A915363C5F;
	Fri,  9 Jan 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972571; cv=fail; b=tmHMfuYhkhU7MqTcWtnTXqv6YrrYMKGnDGw2ybbbWjI9kK9OTDdzYpgxUZBI9bwXryn9LTcbncvqu8jQQOVyKE2HOBudP9TCLXyP8hFj1qKMlfAKyc9TIKGhpn+y7vJqgIlqQX4YvBmV7qPyqeW0XkK+BzQp0tZ/l+T84TTwGyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972571; c=relaxed/simple;
	bh=F+fDFjVxxPgXTCyoMFc6NMQ4XG5kI1uVo8VeRJRlXlc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kmhxS7GuQOF//zFVCZd0B2MtjQytAJ3Q4XdChhpEcqCpqaMCgy7tTTdMvU07URY7H7hlzhidhhtCpemdKIzYsa0mREEcIuyXm7zeF+oL1k/dN/RQjqc2EcjXb2kUnKI0pkBWshiDGqaBIDltBexyW1B5qN6Tpvkn0ZG+tpafd00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hIO13B6V; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSDY/DkMU4mJegaxyarw1MbhdXDTBaR4xUAxNi3ZrCyKVjk2YpE5qapeISvkNB4AFZ+dx9k4kjipirbG024AlaNNf4UajBu0+bCNDohMmt1eF6pZdvYctBzX5JrB+M0ikyhGsyxVegGx2W4tHWDhD8+/PK0pAYTAIPbjDGImMJ3u5Ft/G0Z/52gF0Q3BE7YrakQ8tAL7wbQkpa/49WkBbOTI1j4HI0zJRCgW2zFl1q2WiTm2MdQIsnp0nPaQYLmWQsQzAUyFn0Zl28JGaYon/L3TtQJ/qGlMQt5WVExsiBNqM9HBZ3S1W3+UfTcyc338AFXEiJ1NBcfOJso9KY0CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE0VOqS08uwvWI3sn1olo8/9bX0gvPyMPcy6llRXccI=;
 b=fU+h3QyBXZctgF/rc3Pq/qkiBtsPkd6ZJMz3VLWLuey5EheDrvMe4fpf43yBoP4daYLZRKRHhJM4ylqcgBOLRnvR2ysfo9vikgXxatOpU7dSzRiiyrZs/U6MlhwoQVIGIam71ztzFjBtqbZmLWSHcYZcnUrJuVM2hrY94uoAmx8j6R1BKg9F9c0sXa5g1+ECfT8PKG7dWm9oldkJKozfkhcbAofL2bfzkQB9Yd5Fe34azmU8ffEbtmj3O5x5OeINisweBA9dJSzpFJlO7zLy7Ue/1FkDbJvSpDw1PDj1eQGJx/m3bfjf6yH3xSScac+uy8lXhIbHesvtQJhHiZOUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE0VOqS08uwvWI3sn1olo8/9bX0gvPyMPcy6llRXccI=;
 b=hIO13B6VG+14aCAVtEd7vqKSS1NjIE+aYiMc6JPHaM9ZZl+wJElzTeIXyDSeYN/vWO8ZtNOHOHUng0mXGl3jzOBPd+xcj5Vyj5TrFYwTfPQtQRBQLrzBnyW9lzUvSl4OL90EjOrLt9h5k58QPsbXzoisSFqwovQE/Bfz+n5X7VQVehyzij8R1RkGTOJrMyzi8LxlKtu1hU8sG+0Z5PyE/dhelNHr5/Ay669LBI0YKIMyW5NBx1h69ofiPxfxi+IkbtKAjTJCtTtfLed1XMjnfbocMkl3Aoh2Wg9AD1nM3G635JrhHKpMZiVoGTXXCbhO5vNHwIjRXVwnKuEZ85xMYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:24 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:27 -0500
Subject: [PATCH v2 07/11] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-7-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=7895;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=F+fDFjVxxPgXTCyoMFc6NMQ4XG5kI1uVo8VeRJRlXlc=;
 b=OAHtQMH/UHWCQfY691prG6fOsPyPK7u4sn+A5jcUdK75f2PZHVzz8yvpeFlaMxNbzSw1/K4LJ
 o+LsNOgbTiRBqR0mh48h2poSNVTgsgsp/1eG4em39/A+K5ieC/lpY53
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
X-MS-Office365-Filtering-Correlation-Id: 4d3bc744-a29f-4766-fe10-08de4f93de1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFdsNVV1cUZYa2M3SVJ1ZFBPa0RxeXlsQ1A4WklPWlFSY0NWTlg5bTMvZnJB?=
 =?utf-8?B?amFyc0pOZGx5aXRlNSs4K2d0cTFyeG1QSjZzcXYwMHY0MlRNRmtLUWRON1Vw?=
 =?utf-8?B?SnZydDNWUzRZMkhlNVlucVBFNXRDTjNJMTBSNUppRmdQZzJ5b05Sb2ozWWZZ?=
 =?utf-8?B?N2pKZDl5a0o5R1VycmQxaWRYVGx4TkxKcDREbHZ1cklBY1Z5REY5WXNLR0V6?=
 =?utf-8?B?QVdtekIybGNJRTlmZVNTVkdkNkxGTEZpdytGb0tOQk1ickkwNlltM3djRGRO?=
 =?utf-8?B?N3hpT1NBUU1wVnYrR1doUmUzVy9QWTB5ZXZUWmFyMXMrVGhxQyswaElFL1py?=
 =?utf-8?B?aXRzbUpaTUZKSEhaMGk4N3dFUnpGU20ra0gvRUhvMnVYd0cva1I4RDhqRWZx?=
 =?utf-8?B?V0EvM3hGSDQzNXFvVjNRTHhHVnRKL3RqbEY2NEtKK0lyVDZuaWxhWWJGQWRM?=
 =?utf-8?B?UEU3K1YvOFRQQ0FJdGYvL3VmZ1ZnZVBNME5GNE5lb1JzRGhKaFZyNUZCNC9Z?=
 =?utf-8?B?d25BZVZYWGJ3bWNKQVZsR1k0dkV6TFlKaFR5VFBweTZRbFJudnRQZVh6dTYz?=
 =?utf-8?B?MlE4ZC9WT3RFVnJld2FIMFU4RFBBQTF1ZHYyMGNjeC8vUmVUQldlMDhWSE1Z?=
 =?utf-8?B?VkhZaityY0VXNXFkV2I3bGNObTlWYURVOFFTTjQ1dEFsMHA2bVFFbWhJMUtX?=
 =?utf-8?B?V3JRV3FuRUs5UUdlcXRjRlAxUEE2aSsxT0Y2OGdLV0VxQ05ZMjJvVno1MzNC?=
 =?utf-8?B?MjgrekZHSVR6djRtZzhXbWxCNGhRZDVMa2VHNERSd3ovQXhrTDY5MGJwNWsr?=
 =?utf-8?B?ME5iRjJXa3VJMmltaStXZ1ZCR1dNM1RjQXdqZU5RRkRTcDR5bEFWVU90TXBJ?=
 =?utf-8?B?QjBnZSs4YXNNbDdkNG5qSU51UGJhd1pjQXVyQWwzRzdNMUVBdTBFZXgvZWU1?=
 =?utf-8?B?dys5R20ydytmNnJobG1wdzd3QXBCWjdtRDFpWllSLyt3eU1RSlZRZExCMHJz?=
 =?utf-8?B?MnlvYjlsblFNTXNhL1Z2eU15b243OGlLM3Z3bHhBRW81UlFROG9rOVcxQkF2?=
 =?utf-8?B?NXdhczVnbEw5bXVENnVBVUJsS0oxeDdTUXQxRzFmNUI2RUw5ekdhWnFJRWEy?=
 =?utf-8?B?SkYzMGxMdWMrR2daTDNwUisxMVlzdWZ4THFBc2dxTzJ0M3d2dFk1THhZd1ZB?=
 =?utf-8?B?WDMrejZRYlNDUWNycG1zWmZHaDJvTnU4Tkp4U1JpWjN4bm14RmNMYm5kTHdq?=
 =?utf-8?B?SytWeDNMVFBWSXR0UXB3eVVvSk9kVkptMHJIZHZhZ3JRdFVVZlE1TzNKd0Jk?=
 =?utf-8?B?dExwR0VId3BhWTBaZzVxNDJCV2FlWGYwNTFlQkhXalRUZWs4SHlkWnJ3V21u?=
 =?utf-8?B?T0hsUU5SdUljbnVsSVhnVDNzTHVIanZRcTViamhub2V0NDBUSWlQRnNqVUdW?=
 =?utf-8?B?RVZpejVVdVVoYjJlcVhRRzRRN0tScmdBblIzNjFrT00rTkhzTHE5dVB5OGRV?=
 =?utf-8?B?RFNqQ0ovNXYwbTJteGJkZExzeXU2ZG1LdkNSNGNVc1QzNS9KcGcrTHRmSlh2?=
 =?utf-8?B?aE5CWUtwaGlBNGxKU2NFYWNFeW1HU01kMlp4bnhmKzdMcCsvcWRtOTVPR2dS?=
 =?utf-8?B?Umd5K3U4RjNiVHRwbVB6aEI3ZEpKNHA4S1NrTjA5UTdUT09CTjd2REhEck8y?=
 =?utf-8?B?Z1J2M3dMWXE4dkVnNWk4YkRJcG1YditvVmd6bVRNSjVtMEpvMnBTeHhoWjBk?=
 =?utf-8?B?VmtZU2Qwd2d5Z05YQWh1Zkk3ZWQxUU9rNm0wcXFkQk5KVUpHWWN1UmR2dTBt?=
 =?utf-8?B?K2R3RGJEVzJISTQvcmVIUEZxZVlycVEwZ1Zwb2Y3akZYZ0tpbTRzQnNOMnp5?=
 =?utf-8?B?NUE3Z0RTTU0rZ1ZFVVgrQy9uTXhQVkxFTU1Lc0Z3Z1RLMlR3ZlQvWXRuSEw5?=
 =?utf-8?B?Si9pN2FiengrY0I3YTRQbStFUFJVZVMyemJiR2xENU90elllSm4yMFRLQXdo?=
 =?utf-8?B?MUpHTTB1TFpQWFpKTUwyMXhXbVVFSkhBMzJ3TXZzSFArZGIybzZnNndWbEFU?=
 =?utf-8?B?aU13WUJ1NDh5MklycFhxc2VmdklMY2dXRGNiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJOamdTZFNZVWlObnlYOGloRG1Ma09IY2o3K0VKeFR0WXlPQmJHSTV5a1Fo?=
 =?utf-8?B?OE0xeUxxUkFhV3FoUHk3a0kvRExkNTQzNjJZcDJ6MndtQnAweWVLTEQ5RFBR?=
 =?utf-8?B?RTlOb0Y2Z1JUWkMwakxOM0NQdDE2RHZMTUVTZW9oYWxZbDlrZVBFUktJMEZC?=
 =?utf-8?B?ZmRwc2JKZU9oWHlFL05UVlVmQngzUWt6Rlh2WGx1cGpkTDQrQ0kwVmpwUEdn?=
 =?utf-8?B?djN1b1l6SzBpU1RNRmM2cmVEc1NNT01UYlI4V01aWjc0aFJQYzlqd1pTSDk0?=
 =?utf-8?B?YWtob3czQ0hmaG5NTzk4TTFuUElzaHcrTU9tb2cxS1NlM3BNZzFLaklXMER1?=
 =?utf-8?B?VXJBeEhZdVBPTnVaM1JIdTNwUXlnallnRlFacVo1MjI1VnRkSUpnSVVyNDZn?=
 =?utf-8?B?bVhMV3k0anNnZnI0M3FiUDhpOU1iWE5FNUZuWVV2TEtGTVZqRWFUY3RaUWNT?=
 =?utf-8?B?eGczQzJPdVo0c1U1NUh5QWU0cFA1dTgzSDBLVlQxMS8xMlhYbjlhQlYxY3Z0?=
 =?utf-8?B?OHVVNkRXT1lucnZYeGJKem5ycjYwUWExM3pXaElLNEVXRC9HS2VjTGhlTmlQ?=
 =?utf-8?B?ZHJnTWNYakJTL1ZWb0QzSVJpVUVQV21VVVhIWW5NTEdVek5pVkVvK201bGtk?=
 =?utf-8?B?N012aWxBK1dzWnEzTUJHUTNlNlpZUmQ0ejl5YVFVbFYwQS9lNkZGR2oxT29K?=
 =?utf-8?B?TTJqei9EeUQyOFdzUDMvd3UwYUZqT3RVb1ZiOTQydThTb05CMHVPM3V0dGlZ?=
 =?utf-8?B?bzdKVW1iOGx0M3Z0RElWMGRzc2pscWxjWWJkV2NVSk5nYjJkM2w5TEt4TG1B?=
 =?utf-8?B?dmhMdnd4d1N1WlZnMFVBR2ZqU0VUaEJ1SnVOTi81c1lnMXB1d3hDSGZIOW9Q?=
 =?utf-8?B?d203R05xUy81TGdVS1F6OGV0VXRhYXRiVExRYkI2YmpCZWl6UTNrSzlLQzdN?=
 =?utf-8?B?L1p1cGR5UFN6WjhXdjJlanBMVW9zay9lWjU5ekZYOUtvSXY4Vk5tdFRlSHQy?=
 =?utf-8?B?VlNsKzViSmE5Wlh3ZGJBYzJ4U3R6UnNaS3pZdGMzcDZITURwNzdIVm5Ga2FP?=
 =?utf-8?B?SUpEWDhVbldsaXdLUlJoT2NsamdQT0Z4alNkb3M4WmpRYndnbEQxUFZLdzNZ?=
 =?utf-8?B?Q3YxY3kvMU9iSjZjdWlkMEovcURheWhGUllmR2c2VDBHdEJZTmRTa2UycGVh?=
 =?utf-8?B?K25RVTdHZnZ0OWtQSFNPUktXRkFxa1ljSGVZMWhaQmVPR0VQcDBmSkRpWExD?=
 =?utf-8?B?LzU2QWM0a1JGY1RsRzBHbU1nZitaZ0hWMWZaMncweHc2cGNxV24wdlRCS3Nk?=
 =?utf-8?B?UWpkbXpYVDJHUmI3RXp0anJmVUd3WWdkSUpiTjBEeDREV0FJdnhmYVh5UnRy?=
 =?utf-8?B?b0twQml4NUdPd0lvZ3lRZC92LzVreGFRcjFBU0Y0eGVyWEFLYkhhUkMvOTlv?=
 =?utf-8?B?OTNtR2FSdE92TFdpYW9vUEpBSmY5Z0VXNmVqc1ZOSmNGMnllb1hmVVZCRGlz?=
 =?utf-8?B?WTNLdVhvRndrdDRKa0FEampDSmFneVlmanBvMkpwVnpHUVVEd3U3OUQvQnZy?=
 =?utf-8?B?NHgyVlE3Y3RuQVZQT0ZCWnQ1ZGRGYkpOMXY5MEgvUVJsNm4wMzJyNFJ4T1ZV?=
 =?utf-8?B?dzdydDIzZE1KczVjVW5ONUpkeWxCWmxyMTVvOHc4cXBQYnFIdUZhajQyV3Ji?=
 =?utf-8?B?Rk4wU3VYNnoyaDJhTXRUTEtoeFI4Z2wvQnBITmkwQVdBeVBVWE1oSWxXbGVO?=
 =?utf-8?B?SklwZXVLdC9uU1IvVm0xV2dkYnhhaEd1WFF0S0FTVFBobGYwM2xoeHQrN3Q3?=
 =?utf-8?B?YVRtWmcvMjdiTG81VjB1bUFNdElqR1FnWVR2WW02V2tlNzFJM2F0KzFpMXQy?=
 =?utf-8?B?QS96Q1dlUnVkWXFEeCtXS0Y0TjF6LzFGcnRtM1h5NVhtOVFxN0tDYjJCTkFh?=
 =?utf-8?B?aCtuVCtCd0FFaWtJUUVIQmpuNTlOcmtZYUJoS0RVSTBUb04zb1N0bnhZeEJJ?=
 =?utf-8?B?bjIweXpWaDY2SjBJeG1SRTFnMHUwQ0VDT0ZacDUxNW5PQ3pwVWZqNXI0d2Rw?=
 =?utf-8?B?UitDZ21KQk1Kd2dYRHFSTXgybGtwdTdqeXpPZlI3clhENjJVelhjaHpFYlFY?=
 =?utf-8?B?Y0JXTmxxZUpKeTJKYmVLZG9DMEhMZUM1QlN1eE5PZHp4dXZaNG1xMndJVlZ5?=
 =?utf-8?B?ODdOUExGemowSE55U3pia0w5dGhiSSs2UXAxYi9kZmFhSVQ3czB6NnVsY052?=
 =?utf-8?B?S2hCUEFzQmdIZ2d4bjltVTR5dGJqUmFjYi9OYmJyK1NFTXJ4WHh2RWNCbGUz?=
 =?utf-8?B?bWR3WGFUSjdROWpPa3NJSzdBWElGeFFaK0U0cnI0ZzRsUVI1MVA4QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3bc744-a29f-4766-fe10-08de4f93de1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:24.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf59uoOKB2TlGDTi0lxWvXzTleji1c6+Y+MrGLxZPZ6KdSfwv2ljdSs+bR8WwucFplPWtYIqcQC3T5ISPiVtsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  49 +++++++------
 2 files changed, 91 insertions(+), 86 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 79265684613df4f4a30d6108d696b95a2934dffe..1f1bc8b8d04aff85ddaf0b077fd01a87ac54046f 100644
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
index 27f79d9b97d91fdbafc4f1e1e4d099bbbddf60e2..953868ef424250c1b696b9e61b72ba9a9c7c38c9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,31 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
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
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,30 +257,12 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
+
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.34.1


