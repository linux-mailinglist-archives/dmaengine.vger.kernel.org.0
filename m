Return-Path: <dmaengine+bounces-8159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830FD0AF0D
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED9230B5058
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C036405D;
	Fri,  9 Jan 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hof3Mf3E"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A8363C6B;
	Fri,  9 Jan 2026 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972598; cv=fail; b=bTYsjoI+2YlMu4FAwpwJrHvtRZoGBdGzeGGpS+VB6zvmxOMZocMVaIsWQQNJztE9Rrfo/HQmFgGgwgMbxTtAhicAHAtDbPxblVPKQ+bP6C+NHBNWsLVhSdWt6tUmXzzx36PkOPQPwUUn/rDzgSEQmDvt2IMzsQtc/41FxJt0bPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972598; c=relaxed/simple;
	bh=MBm8m99XtWbpldQ4gR4o6okXv1EWXhF0JTusf76GutE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nYJ9FUGQTHf/yqOR2AiwRLpnTjfUT9uWoD8D46RiNNG+6OmLKQYiPZn3YKqfgUq8UVpR0okqc61zBtE510ZjRzVjE77W0G2j4FR5EA6kCZF/YAt19AEoY+FQFCdsZdhrrmuMSbxnFuMt5KxyU+He1mZdQpgMxe8s0wlM3ifzmFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hof3Mf3E; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK3LczwHXszUdDT3Of8UPSx+f8vcTxiiffuq+ANCCPT5WweR7NBfJGaOGgR4JOFIoHJpDkFcPPpjRppYIF48kFtHkkwMHol0blvm12DXkiTBGfYEiFNFZ3ZEj9N1gQi34a0xz2ImaVLupI0Bf3WHImWuQ8oW6I0vpgyw+Q92hP7pZS5sOMQOJFbl8kxJa4NNHQ0Pt69egFCYR5WXbHhhfSN5sRiXxhUhsHGNYI+htVvxhwN/LpTyzi/oS6hOVw4r/UHkB3wukmjQTj0+Sos1epfWDJ8gTjHN6qhBgJSDYa5KbgxHnNd+/6szN6p6aIN+fFqLoX93VtD5w1CPEQvLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gP0D2MKYaBVrraKFEChRq6F8ogUj9T2EOAq8KJHrAg=;
 b=JwS3OSD+lGKEfYXT7D/A6QMCInsC3SzNkc24kk+UdHLEu6Wo0iZF+hImq3oIBWPu/FcKBgccKan9+Zzjzrb62MUnguNADEFG+cb0lp0zbsntmcAtgqxWmE9m8NF/VwO6+TyN/jVDh2/JycRrRXt+rRAZtH3PPUDU0Rw+egVtMA8oipWSEMci5QFBPKHlq17WbPAW1H/sbGdvxaSdAIQ0FLZWOXqQEi66bSH3KOBY6kASOmsGTjMis7zsICXHCKgABz9R4r24EksaAUpUtudzQUxn297jKiWMXBGCqaLJmf2KjGtj708uaCrCy4u2d+l//LmNhJ+dueA63Cj1KjQoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gP0D2MKYaBVrraKFEChRq6F8ogUj9T2EOAq8KJHrAg=;
 b=Hof3Mf3El2ZpwZfJTItvFmHghFwkNmTyqvRqm0K3mtOyAOmRi1DuU5TJx1RIdLZwumOV1k8Tk8F6Ngr4wUpp9t21lvgLMV0NnuYQMlRDsx6dpvO5bNw7+xJoUrBYJHEAyWN9A1HV6mdcZOYNgN8VfcZRuh5xFfJZ4LElcNzHtAKTu9aC4bGQTI9mT/AxSgNO69qF8jDr+cqxsww69XTghGz231r/7OhAi/Qw1RGfksDO1iVDpTp1fpC0Y4CB+l0YoIxpspeBTwp4kUZ1Oh75BU6A5oCxRU7tGxWRb0oWpRvwLsE+Dq+MzffL4w7yDXSyETXuHsO4xmchL7PETWrNnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:46 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:31 -0500
Subject: [PATCH v2 11/11] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-edma_ll-v2-11-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=9560;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MBm8m99XtWbpldQ4gR4o6okXv1EWXhF0JTusf76GutE=;
 b=pLWPoj1CeA6OVZkEgsRmooCim84k7aaKZeLoZQQcSK4ebwZ6AQcQY20fEsqiuqNfIgrabGa5/
 kcc1uZvdof5AaTsJ1r3S9CNTXJv5ibm4pw2WPcrTxmYiWapskmWCbtF
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
X-MS-Office365-Filtering-Correlation-Id: f642e88a-afd5-4281-14c1-08de4f93ebaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFOd3g0TndzdTRCb2tuaHA3MDAyYkJmbmRtRE5taWNmcE5kZC8zVVlFczZa?=
 =?utf-8?B?ODF0ZFppdGlldFYrYXVhODc2elVmUXh6WDNkNDdROGVLb0cvelpZc3FrT2kz?=
 =?utf-8?B?ajZZdG1HZEZ5Y21ZTmlReCtJcUlVSVhNZTVBN1NObUk5bE1wd1ZBK2E4Skc3?=
 =?utf-8?B?R0dScCs5dzMxakx3TjY2b2s3TENJWjJpZ1lSOStidEc3L3VMZDZkWEh0K3Mr?=
 =?utf-8?B?cnF4RGdzcDV0bUZ1UGZwai93eTQ3TkJlWmNCRURMZEYzT1lzR0V1ai9xdDM3?=
 =?utf-8?B?Y0F4Ym5VSG5aZ3BSQXRvekRrM3NoUVZjaXFvaUEvc2E1QTB3Z1hrbFp0TzZO?=
 =?utf-8?B?aEl6cFdXeXc0WVdDbW9aREpLUkRERXB0ckU3bXdHVlJHSWxpN0doOTBRVmNO?=
 =?utf-8?B?Y2dDUC9Xb2Z4OExiMFFjK21jaUQrcjgwNWpLZmxGL0JKMUpLZGUyM3l4SjEw?=
 =?utf-8?B?YXVKc0s3d3lwNE9zS0hBdS92aXF1RFNtV3RCVzFMSHRPNVAvdzFhcE5qTGJS?=
 =?utf-8?B?Q1BXR1hsWmtSZjgwTnZUajNidk5nZ2h4cWwzdDFZSlRCZTdSeU1Ud0tMZVVL?=
 =?utf-8?B?OFh0eHM1ZTczbGp0ODlOSTdDeUtsaFB4blMydmJIUlFNRHhmS01xYm5NRThx?=
 =?utf-8?B?cFlwWWZBeXFGMHBqd1NPUTFLeUFhbVFBc3l5YWQ3THNRY24yWGYwQnk1OGdX?=
 =?utf-8?B?U2NZdktBdE5FcVUrbk1rZ1IyU1lMakJkRnVNNFdBNVFTVVBhOFJ2azF0MWM2?=
 =?utf-8?B?dXo5VEpNTHE1T1ZUeEk2SCt6dGU0a3RjQ3A0R2R1bklaTlJWZnlJLzFMRXJP?=
 =?utf-8?B?TGpQS3RRem9qRGgydkN2SkxEWEh5eC85eURIdFRyYlZQWHpFQVpuQkwraWRn?=
 =?utf-8?B?SlhiQVFBU2dYRnlQY25ZbGxqb2hraFN2UVhrd25QNGdmaDAvaUxnZGxBQVNU?=
 =?utf-8?B?RGZZYWUyRzRuOEZoZXZyYldCRm80YjN0NkJJenZOQXkxU2RpN3I2Zk5aUlps?=
 =?utf-8?B?VnJCV3RBK2JyeTdLN3h1N0xjVU5TVEFEV0ZmNTdlc1krVGZ5ekJ5elZYSFJr?=
 =?utf-8?B?MmdmeVgxTUxFc2lkNXVKYVBiV1hXeDFkanFNUTh5Uk1FcFplb21IbXNsSXRO?=
 =?utf-8?B?SVoralljRWxrdXhxZEREK28xZWV3TkFVZkEvV0YzZWljZjlHTVlZT2NLd09C?=
 =?utf-8?B?YWdXUUVTdnBGbUhZTFlLUGJ4dTh2eTNNWEErOGhyMlhKY1QxeEVNalh6RWlZ?=
 =?utf-8?B?MmVXZXowamFRekJBVlZSQjNJWU8zM0N2VHpVVklBalBXZzdEbmJEd0FQZTAv?=
 =?utf-8?B?L0xVVHZRZkhCZmhhdFdkWUppNVFxclgvQmhNTUQvUmVLU1VmbHBWSEJiYXZX?=
 =?utf-8?B?ejRIakQ1aDRuUTJqSlA3T3R6UDQ5cG8rMitHc0JmWGxlWjZpa3l2V0VHMDhR?=
 =?utf-8?B?eXVkbUJSM1VHVzUwMWFHR0cxWWJEVVFrZ2xKQlhYRXlkNWxISmRjUmxESW11?=
 =?utf-8?B?eVhaM1NIVGhJYnpPSkRGZjFTWGNZTlM2TDl2K1Fwdzl1UDdQTHlSQmZXaG43?=
 =?utf-8?B?UmFZeHlkUS9zdHJ1WFBjMVJIQllJeDFqOWZ3R05SVlp1OE9LeWFWdTdlM2VU?=
 =?utf-8?B?by9Jbmo5WWgrSmdHVG82elpEeEpKTEZubC9OdENvYkpNcE9iQS80djNWU29p?=
 =?utf-8?B?Sktjc1h6SmFhTmtOM3Q4K0EvZGI0MzJlYm9vclo1OW0rdlN3QTlPaUdxVHE1?=
 =?utf-8?B?dWRNMWVSaExjSGlBakpYanNRL0FoYTV4dnlJZ1F5MUdlcnhXNVBpUzliUEo1?=
 =?utf-8?B?S0FoYW80WjZIeXdnamxzdU95N1lhdG9PSmJjUzlZZWltZXdiKzdMS2VUc3VQ?=
 =?utf-8?B?OVRrM1g4NXdLZ1NocjhHU3hDbXlQbXlwVTZpQmJwaVh1Z2pZU1RQTWZUQmYw?=
 =?utf-8?B?ODkzaGhrd2RqaGs3VzB2eHlvYTVVUmZwYWJZRU5QRmRRU3ZkbDkrRXQxR21B?=
 =?utf-8?B?M1U4cEpRS0daRDVsNVU2OEI4azVNeUpicEV1RDAzZkxVOUErSzR3dlM0dEND?=
 =?utf-8?B?Sy94eENhdDBGa0JoT0EyNmk0cVU0SFFUREJCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1BocjNrbytTYnVieVZta2Z0MW53TlJ2RDN3ZStEK2RwREUreWVmSXc3ZTZj?=
 =?utf-8?B?U0ZtR0I2ZUFmYUJIMGpCZWxlRWMxOXk4dTVmNWgzeEhzTzdrSnlaNGpiT3d0?=
 =?utf-8?B?OEJqaW12cEZGZUpJL0lEbEo5a3cvbUN0dUdxQy9oZHZVbC92OUdRdS9GQk9Z?=
 =?utf-8?B?S2F0WHZadkFGakY3cURpbzg2NHZnTFZCSDU3djgxNzVKWE8vd0FqcHA1cFhZ?=
 =?utf-8?B?czFFaGFNUkxLS1hWTWV6SVhmaGt4U2lsNVhJNUR5aERxLy9HYWwvQmk5S0VZ?=
 =?utf-8?B?NWhaL3VZUk9BM1M5bTBRbDNwcVpNenNoUVBObmxmQVdVTmNKU21ib1h3d3Vz?=
 =?utf-8?B?YTNUU0pEaFpUc0EzamlqUWNGQUIvb3RGaHJhUmxGSlFqdzJzYXBFQUdqVVAx?=
 =?utf-8?B?ZE94dmFsZzhnYnNBeGZoV2orV00wU0IwOHd5ZFdHdVJpZmRlNGMzUmtaRTJW?=
 =?utf-8?B?MlRteXhvNEZIenhuMlRweVRYM2VkZHhra3g0M3FFV0FBeXhHNmM4WEtGQnhi?=
 =?utf-8?B?UVVLcmh0YTNOWi93Tk1IYm0vN0t3SHpYelJCZGg4QzI0c3NIWVU3dzZYd0Zk?=
 =?utf-8?B?NGdEc2U2dlp0bU4zcTQxZHpSclJhalVHUDFmZ1BpK29BNVprQ2pnZHRORURv?=
 =?utf-8?B?Y3NVOXdFMnBybzVpOHI4b3Vyb1FKcGhiT1QzZi9lSi9pWmpySktWTkxibk9h?=
 =?utf-8?B?dFJHcVRCTDZMQVJudlA2Rm1VVEwrVklXMFlvbTZGRUZGOTVnMUdiK2tJWndo?=
 =?utf-8?B?blFOeXZ5RVNSaFB3QUNHa3J3UmRSRjZ5bUw4ZU9FWDVESjd5anQyaGxWaWQr?=
 =?utf-8?B?aFBxdmFhOG8wQU5zWVZMZ2IwcjM0NmdzT2U3d1VhY1l2NzFzbTN6VUlIQ1dY?=
 =?utf-8?B?bWtSY1NocFpweFVxZG5HNWhCZysxb0lvSTFhMVdwTCtSY0w3WWc2SWp5d3E0?=
 =?utf-8?B?YUlVK29yVUxPaDB5OFJIaSs1TklsN3Q2ZEZuNmNUTGFkUWZxalUzd0dQSGd2?=
 =?utf-8?B?eHRSWkN2cmdSS2tzUWI3Sy9xS3VHdURqNCtUUVVTZWZHZTdvaUNtWGJIQkpF?=
 =?utf-8?B?YWJsVmFpVm1SaUJUcnhGSGt4bU5aM3JDM2xyRWVPMnphbFFRdFk5SGtZNzZL?=
 =?utf-8?B?aFlWTy9QRGc5Zzk5dmNJTFJnN3RhK1VES3lZUzdtd2R5M1JZVjkzK2FsZGlW?=
 =?utf-8?B?S1FNaHlVaUJtSWZaTVNmYTl5eFIxN3JTNDVqTkpaTlNORkZVb0s5Z1VlMEY0?=
 =?utf-8?B?bklMSGREYlhtekJkbjJDbnhEeW4ra0lPWEVoTVN1NDh6WTBTZ0tjKzNpdU5V?=
 =?utf-8?B?OEJ4SktkdU02N0pGdjRmLzl1Rm1zNWNVdk5YbG1ROWx4bTNSTXhGZjVHVm5I?=
 =?utf-8?B?N1dmdzg5OUxSSDJJblFFU2czczl6T0JxNEZLbUp2cWFnYmloYzdKbUkvelNG?=
 =?utf-8?B?L0JyMFZXMDRnV1ZLNzdTUjYwcVNrVUcrc1NQb1lmajR0ODd6dUpCNDJxWkVC?=
 =?utf-8?B?WmxrRmxIdVFPNVEwRE5OWVk1ZWtIYzFpSGNHWEVwZ0tlWDg4OXBrajdjSVgw?=
 =?utf-8?B?OFRYTU96ckZmTXRDeEJETVFPSVdoaDBUNStmN1NKbmJsQTJPajVndjlrMFls?=
 =?utf-8?B?OXdHZ3FpemVXN2g2bC9JeFVGNjdCRVVyUG5ObnJqVmh4cXBuVFdrc0pKR0tD?=
 =?utf-8?B?cjZpVDRzSmJuWFVBUHJVTS9Fd0EzM1dNUnpnUFUyNC9GSUV1T1o4aGIrNkRt?=
 =?utf-8?B?Y3FOMUt0bDRJN3Z6cGUwUlQxbngyMCtqd2JrNkhJbUJhT3cySWlRRU5oUzZ3?=
 =?utf-8?B?eE1ad092UmFWOHd3a0tOSlBzZ051VXdTRkhyeE8yanZUcEFZZ1lzdnlLSGox?=
 =?utf-8?B?SUR3TXR0WXBVVmFpQjMrVWozNTRCV1ZUektZSnhOSlNROFgxNWZiZ0RVVDRx?=
 =?utf-8?B?WjZ2UGVoN1ZUKzFMOStBU2I5MFowMk9BVmtweUtQYXlpRTZ5Y1hDd2thVnZR?=
 =?utf-8?B?Uml1Ui8vNEQ3bzhtRlFNVnpzb3h1dWJvTUhQSEtidjcrVEM5S0NGWnZzd2lN?=
 =?utf-8?B?UHVWNk1OZDhlWm9NWVd3WjBLaWhUUEcyTngvWnFxNHJHOHgxTURVTFM5MlNF?=
 =?utf-8?B?RVBETURBSTMwV3Z4UUk3QWVSaDcwcG44OWp5UDR4YjIzTXJDbmpaS29RQWJG?=
 =?utf-8?B?WFVvMmtlblNSWE8yUWZLdGxxbFJXUFlleU1BUHJDdXNjMkhxcVl5MU8wcGpH?=
 =?utf-8?B?Um9VZUhnMWtZcXBUMkxWRk16ZVY0RnVaNmJxM1haMk9Cc3RhY3kzU3VBVnpC?=
 =?utf-8?B?TEtzcnJhWWd6NzRYUU5hUlhZd3FoU2I0c1l6MmZVOGNuS05FTFpoUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f642e88a-afd5-4281-14c1-08de4f93ebaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:46.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSZ31TRPNU6zU9WBVZvFIsVVYJWiP16MFs93HMjWjUr9QKt6+jU7aoL+pErTkqAK0ALKqDVf5nBPKZUw896VWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 128 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
 2 files changed, 56 insertions(+), 96 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 9e65155fd93d69ddbc8235fad671fad4dc120979..1c8aef5e03b0e2c93aec9f1cb0588b4e8b1508d9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,76 +40,45 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc(struct_size(chunk, burst, nburst), GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	desc = kzalloc(struct_size(desc, burst, nburst), GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i < desc->nburst; i++) {
+		if (i == chan->ll_max - 1)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
+				     i, desc->cb,
+				     i == desc->nburst - 1 || i == chan->ll_max - 2);
+	}
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -119,7 +88,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -131,16 +99,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -289,8 +250,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -307,7 +270,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -369,10 +331,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -396,19 +354,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % chan->ll_max)) {
-			u32 n = min(cnt - i, chan->ll_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -417,8 +371,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -473,12 +427,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -551,8 +499,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -571,7 +525,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e9e0346c35b1917a5ef2c545fdf1754d18684154..31039eb85079cbbd38a90d249091113ad646c6f9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,15 +46,8 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
@@ -66,6 +59,12 @@ struct dw_edma_desc {
 
 	u32				alloc_sz;
 	u32				xfer_sz;
+
+	u32				done_burst;
+	u32				start_burst;
+	u8				cb;
+	u32				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -126,7 +125,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 };
@@ -166,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.34.1


