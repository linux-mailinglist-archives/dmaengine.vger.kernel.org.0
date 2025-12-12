Return-Path: <dmaengine+bounces-7602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20031CB9ED6
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3CC3301C644
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461A313293;
	Fri, 12 Dec 2025 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7CjMmQ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0030E837;
	Fri, 12 Dec 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578399; cv=fail; b=EeFQMIPO9iso7A7GNwfJG8t0TMsMyq/dIGHZXwnyBm4QMEZMXqj2+CoysbLKH77Pm0qJ8MsfN+GIr5d8QQ9MZIXWN1BatOKuR0b4+lMIJTXQD7FIYQnEwnDG6j0Fnq4cK0T5rPd++rl84xAu3aNHh4tB+3dEQXxH2GvBqH5Xxfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578399; c=relaxed/simple;
	bh=fBnDw+EYXXwidHZp+qpRCDOlLUT7tA11elPIfsFmgOI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s23mD3pHCz68lQRE/eemjyhwBiT9bACgn12CrzIfV1EYA+QWrCr8THMkPxu5wG239R0OmWTNtW42K6AdG6k90IFaNr8byT2/6QqECEwT8XymZv+NQAeqLINocXvi1RFuPVHZ2uiqsJYgEH51dgfX5n7Lg6hVBTczBV9ENihwklw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R7CjMmQ2; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccYfR679rMm2M62f1DFPIsBWMeV3qQMM3oNRhyiBGPmk6y9qCvb85xqcXQKQgPr1ki9e6BEPr4+vCdyw+Dcf2MVhPq3lVZLc9p40CqmbCTOiJuXB/B18GZoKGE81dCUga5fUjYaTgnWq0+E+af/+2IdWC4308Bu3XXny+hHaDiXSZf4s/JI1DCrWs2NNwB6UJzC/J2dJ1bgbJAg4GL/HTgjEbtKZKk23iOwIp1HE6F4HGbgkeIT+Qqot+F6Q3i145531daYgryDdPtUljZ6rsn6x3rErcVHO2mTlm4xehQM9Jesph5kZa22V7Hha6p9timHxcsIwK/sZyX8/lOEUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aaTcnBPbk1/yznMwK2s0xZBU4acTu94pWz9k0dT5Lw=;
 b=Ny2aBRGho2JbgmOoYCz49WGpL4GmLqnJGj/rw3uACV9sbgOEUZQPNGsivFrdhubAvN8gX+9yMhnoCf1g3EWXHP51yOB+LUI7EyyTdpCSnPCt4+0TDQI++hRR03BWKZReM0qoTEqa9YINl10+D09me+yalVit/8Gt8UjyYj9OxYCR3ZKil+ReglF7cprEjN5rpBeM0XpevgqJXZkjTqio2YyKqA5h7eK/krGCbVFwRrll1g/D41r2jg0MQt9abkkrW7Dyfzn02Eefw8k7iRaBdiKwKhNHS/vUz1Y4z90ZF3zEMY+iFhiyzqsDPrk+NxJaflu7EjGDQhdLTXBkplUnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aaTcnBPbk1/yznMwK2s0xZBU4acTu94pWz9k0dT5Lw=;
 b=R7CjMmQ2X+8AL5ZfTljBytCseMruQdZzTpDod1ibRL0gMcyr2B4kEFxkWuY664h+0Ci33V5SvyUOGYcQdDTw71jAa6vXM4g5TWKyssBaLTuNTXmyCL3IBF/zmeTB3dDFwin/Cf9TvTuicIpsfBo924/6poCQvz6VcASgaCbeH5+qh/3AeRT5YG6R7px9nbBHCNAVysHaHqSgHFxVoMvbYCav6aN1JDeTx8DytkQC7BOPbtvlbXPXgF062UvWpUunW7OKCsUseDfBtSOCmcxYffmLVbRzUYCi+MlM1LTfdJnAwTmzYaYsWzynv88ubAMIPXNBrCHGfnuYUvQByBNxxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:42 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:49 -0500
Subject: [PATCH 10/11] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251212-edma_ll-v1-10-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=7729;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fBnDw+EYXXwidHZp+qpRCDOlLUT7tA11elPIfsFmgOI=;
 b=59ClHemqGAxN3jGQmNRzPhXp2YFJJaFaK9Cy1+ZLd27N0XiYIVwTkzN4MQnYGMnzKelMknIcA
 cnipDLtYtF0AEwxKR/XazcHFq80uqonC3mWNeq7kVHOx5Ee1dvZmg5r
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: ea324ba9-39e6-4551-7256-08de39cd62ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xldnNPUldHT2ZrT3RjMlFBUTNyZzVuNjR0OWZYVDVJU3VtOUg0azNiUU1m?=
 =?utf-8?B?d1VHMlBqNE9SeHM4WU9rRkFrMFlOcHhjSWhpRDMwMXZTNmlyNHZpTFZjNjc3?=
 =?utf-8?B?Smh5bStWRUxPQWJLK3RxTjBUZ2hvOVUzM0V1VzE3V0dSNkJFcmVVaElsVUpL?=
 =?utf-8?B?TjB5Y3BLYjMyS3hiNzhBWTFjVExrVzc3YWY2SlB2MnVhVDhxenJ1dTVlSm5z?=
 =?utf-8?B?NXBQSjd4TTFlbmQ5cXJqTFczd0lVL1NWd3gyRVRweUJDQ1NlNGYrSyttd0xY?=
 =?utf-8?B?NlBwams3MVprbzc0cEI3ZmV6azdlQUpoQ0lyVVI0SlZNVlN5NGhXNTJaVjVS?=
 =?utf-8?B?dUhBOE1NNERjWHFSTXZNMFkrL2MvcGYvcFNjTkRHRkV3UTIybkNpUXVxN0ND?=
 =?utf-8?B?bk5HRjBTalBIZjdrN3hXUDRIanovY2dlY1RXbmZIUTZ2eUZlM0Z0YURMUEVi?=
 =?utf-8?B?dmxmczVRL3JkR3djcXJobERnNE00ZEh3dWN4ZktKelcxSUxIUkVESmpTN0ZL?=
 =?utf-8?B?a2RHR1NoSk8zMDZQU2NZRDF4a0Q2aTA3a2ZuSzV4NFQ3K2JJcEVCdWQ1a25o?=
 =?utf-8?B?clkrbFpZalFndmhkdVpYRzViMlZudjdPbktVOEdDV1FQV2tLRGc4bzBtM1Z2?=
 =?utf-8?B?MXpuTlZ6dS83aTFKVTJwUWpNRWtjTWxIMyt3cUhyUzcwd3l4aEpSL3FzVW13?=
 =?utf-8?B?SkE4aDM5MSs0dTNNUURzS1pRa09WVmc5U3AwYjBUZjhmK295aG1neFp3UlQ1?=
 =?utf-8?B?Nm5BTFRnY0dsdUNFWmhCWnhkU1NsQThyckpiN1ZDdmU2QmNVZVl3RmJTSUNo?=
 =?utf-8?B?dGFmWUc3dzQwcW4ybC9JWVZzWUdGSEU2WU4rZU4vVHpWdDN5c3VLYi8vT1RK?=
 =?utf-8?B?bmszV3lKM0pIOCtnUTNrb3dFMTVwUjkvOTFtT3VQZmhPd2JJQUxKakpOWGNw?=
 =?utf-8?B?czQybkYxR1p4L3VkeWxYeFFTUW5LS1cway9GSnpFcE9BTmlCd3ZQekZHR2I5?=
 =?utf-8?B?ZUdqY2FieDZ3V3JlekFOYUFXcENzcGV2VnFzV2VieWFLTmFSbXA1a0dnS3FP?=
 =?utf-8?B?TGlYY2s5QTNueC9Ld0toSmF1TU1rZDJEZzdiTGJGbnNuUm5aeVhxeEgzbTFS?=
 =?utf-8?B?YXhEQ3RMQ1kyeDRNNkkxZWl2QUZTNHBTL3pRc25KemR1Z0pxQVpmVVhGY24x?=
 =?utf-8?B?cmNUY25hRkQ4Um1RVDlzVm9kM2tCdmQydEgwMUl3aW9LWDZYODdtUytDc25z?=
 =?utf-8?B?V2FsbE9NcTA0eGZPbXo2dURVOHIzbE4xUE1HanRaY2xtL2lyMW9yN1J3ak9C?=
 =?utf-8?B?Mi9iQkZMRGJXNUI3UmorcFZvNVhRMUJlR0llcXlLdEdYSEVieFVpZis0RVFW?=
 =?utf-8?B?N1IvRjhHUExMZnQwelNGU3RQYWY5enRkaTFFb2F5US9RYUdKTndMNUpYT3py?=
 =?utf-8?B?VGFvcml5YnRWT01zem1uWWd3K0V0bEIxTjZSK0YveklOdUovMkV2dnA4Yko3?=
 =?utf-8?B?Uzk5azQzQk1rUklnR2pKNjM4dis2YjFSMG5ueU9sMFNyckhMbVNGRFkxeHJH?=
 =?utf-8?B?elRENk5oVmFQdTIyZWJhdDU1UEE1UmRaZkpCczd4QzZwcGRnVVRDTzBhQ3hh?=
 =?utf-8?B?VXR0WTNCQzNDa3UyWEQyazYyMlFDbzZjc29ZTW4zVkM2RDBEc1ZHUy9vT3p0?=
 =?utf-8?B?OXRiQWVuODlFcVRwSkVER2lWaEp1Y1pRSGlBK1BGWlhGZTU1TjVlcHJwTVM4?=
 =?utf-8?B?elliZ3BtWWc4MlFyd0hSaEpNVGl1SGVKSlhpc0FQOURxcU8wZGJWV2lKbUxx?=
 =?utf-8?B?VnNZeVR1MHhKV2xWbzRCRXFPMFlrbDk4SkZ1WWpXZmhrK1lNME1JY2p2OTdC?=
 =?utf-8?B?Vk5oZ2hoR3FGN0JjRGtFNnZXYVNFZVc0OW5ORjRiY1NPZDZPOG53R0x4cTNG?=
 =?utf-8?B?NXdGTUtnL0xrdDZWQS9nSHBaTWlpRHBkaUZ1Q0NEQVlZSmVzL3pPaSs0Ukcv?=
 =?utf-8?B?Wm04UTJqWVNoc2VIZWlNUG1oSDRYN1p1b0s1WW9YQzV0MDlnaW9IV1p3c1JT?=
 =?utf-8?B?aE05TG1nVUkvclpKTGJuVlR6enhSaENwK2FYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVNxb0h5aWFjeU5KT1A1MHRpL010bTEwZG5zd21IZHNDUHF2WEs0clIrTG55?=
 =?utf-8?B?NStWVHppc3JyY1NxRFZpYzVWc04vZy9VMjl6b3pBd2J0aVdDenBHejlvYXZn?=
 =?utf-8?B?bXlrVjJOWkR2akhWZXRNSjVGZDhxcEZNdFlLNmhJR293UlE4Z3QvWmNmU0hp?=
 =?utf-8?B?RjB1RzFxdGRNTUxkSThJaUU3UGNDQktIdXFlT1p2Tk05SmhxZHVCUi9Pb0J6?=
 =?utf-8?B?UUZvdTBFa3BsYWRsQWxxQ1BHUk41dDZDL3dZeDR2UU5jTUhqVjNZRDlpRmcx?=
 =?utf-8?B?TFN1YkVDMEZRKzhRZHh6YWQ0TVJaWSs3ZzZaU3FXWWo1SXRIT01kN04vRU9E?=
 =?utf-8?B?anU1K1VsbCtPK00rVGtvb1l0R1dNamh2ZFBQNzJselNpN0VBN1YveWhoN2FL?=
 =?utf-8?B?dEhsQ0QyUVVHU3pBcUxGL1drcThwdnpkNlkvT3pFejFreUdxT216UGxTaHFR?=
 =?utf-8?B?aXMxYVNlcXBmZUUyczhlQ0JPRXhqTFdGYlZibXRXT3cwQlVsWWRnYW1VYm00?=
 =?utf-8?B?eFk0WW9Ccjk5b0dZaWZIQkFyZDRaWHRnQVBhTXVDMHlLNVpOemJGNkN2OTA0?=
 =?utf-8?B?U1F4RmhIQlA0WVpQZmVZZW9sOXNaMnRhbWdTeWVCMUhTRVpUMXp1UjRTenVE?=
 =?utf-8?B?Y202T0I1ODNCL25qYXhHViswaXRqaGgxL0hRWkdsYTl3RGdKaGxESVBrVDJG?=
 =?utf-8?B?SEs1K2dackxGQ2l6UUhpeU00TjlEbmtqeUNzNzl6SXdHeGZkaHJxcCtEWmZm?=
 =?utf-8?B?dnd5cHc5aHYrZDlHckVGb2pDcWg2dFY3V2VmVktZdFcxT1Jqays5VHlMZzFW?=
 =?utf-8?B?QldROFFkTDlQVjQ4NlV4aytjSmxWYm9xam0rYk5PMVJmY212TEdxeEVZbjlu?=
 =?utf-8?B?OHdZNTM4OEZUTFovVEUvWHRPQnlEd01RWTkvZDJXQXg4VnRIRnB6MjlleHVT?=
 =?utf-8?B?dkduZS9uYjd6cDBPeHNYMGZWbEw4VWVmKzFhQ2JFVlcxZEptL21hM1dqcGZQ?=
 =?utf-8?B?S2pWSkhkQnZKNFdEamVrTDlqaFIycVhLSmpxK01mWmdsM2ltNVVNSFZyRFlq?=
 =?utf-8?B?SHJ3Q3pTSTA3aThhNUpzU0oxbHEydlFMVk1QQ0NrejVzNlNFZ2E1b2tQMGhK?=
 =?utf-8?B?cUxURms0UkptaWdxREdaWnl4QlhwU09GUUNYcUdRWTRmYUNOSHIxY2NpWjRO?=
 =?utf-8?B?RXB4M2FUczZWKzB6UUY3VVA2R0JJY0x5OUlhZzJ2ZnpVQmFnclpxRC9QejEy?=
 =?utf-8?B?UzAyZXpjZkVnSmFqNXI1YlFjek95YVJ3V1RZdGd5WnVya0lReWhJZ1lwd1I3?=
 =?utf-8?B?cWo5bCt5eUM3OXdycDlaWGRZWUtnejFnMWVGd0ZmS0Y1aVZad3Q5N21EdWhp?=
 =?utf-8?B?TGxuWWU3aDlJMEZIbTlrNlljNkR0WnF2VnRXVXVjcmhLQUVFMFVFYm9mWkYv?=
 =?utf-8?B?cmo5TG02NDMxQklCcVFhTXFic0pNM0xOMnFBU1dUQ3E4ejBhTnkwTlB6ZUJ6?=
 =?utf-8?B?Qkk5eGpnbktGd1YzTkhTWGgzT2FVZHI5SWxjN1MrRGhxSk9QYlBCZkEzc3Rs?=
 =?utf-8?B?MFZieXpNUG8vVGNJRUM4YmV1ajM5U05kcVNFckdnVVVob085eFVDMElUZ0g2?=
 =?utf-8?B?emR1K0Y3S25kNXJxOXd1YU5xVytVa1MzT0Vqcml4Q0t0d0tUU2U0QU1BUDZk?=
 =?utf-8?B?Y2liTzh4dFMzTnV5S1c5U2xQQVg2dVpadkFNZTMxNVgvZnJGNHg5NlRad2Fj?=
 =?utf-8?B?SnBseVkrcmtDYSs2RU9yK3ZXWThtVDJQZGdkdjFUL2sxbmMwRFp0dk1scmJW?=
 =?utf-8?B?dXAvN012UkpXSnZ6Mk5BbU5sRUlsS1UxN2FqL0oybytsY2REYXRZSk4xdlN5?=
 =?utf-8?B?QzN5NHZiMWlBbS96ZUdvTWdsc3VBSE8xaktQb011Wk1wVEQxYUJUaWVtTzJj?=
 =?utf-8?B?M2ttUWVVT2tibFJTWkhiT3daeE9UNE5XM0VxbGpWZVVEMjJ2b09Hb0JRSGFG?=
 =?utf-8?B?dVluRDh2MDhJNFpYa2VYNlNoR2x6RFdwRnFjVmd1S2NyM3F2UU5Gb1NVNmNh?=
 =?utf-8?B?VnRZS3J4L0RNOENoaXBzZVR5OXhaZ3MwRlhTSjFiK2F6aGlEVC9oRm1Bb0tF?=
 =?utf-8?Q?/maA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea324ba9-39e6-4551-7256-08de39cd62ed
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:42.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/zTaA4J/7pWu8ry82jksiOVRMri+5hSZhB5OSXfmuf2wjuowvR+SUGHbpGuo+Vu8pMN49z/VTakOSj0Zu3Gfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 114 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 24 insertions(+), 99 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 37918f733eb4d36c7ced6418b85a885affadc8f7..9e65155fd93d69ddbc8235fad671fad4dc120979 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc(sizeof(*burst), GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
+	chunk = kzalloc(struct_size(chunk, burst, nburst), GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,15 +103,11 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -198,14 +131,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -375,13 +307,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -441,10 +373,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -472,15 +400,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % chan->ll_max)) {
+			u32 n = min(cnt - i, chan->ll_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 7a0d8405eb7feaedf4b19fd83bbeb5d24781bb7b..1930c3bce2bf33fdfbf4e8d99002483a4565faed 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.34.1


