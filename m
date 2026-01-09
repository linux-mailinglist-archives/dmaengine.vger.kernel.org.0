Return-Path: <dmaengine+bounces-8154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD73D0AEA7
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E6A7306304A
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B3363C56;
	Fri,  9 Jan 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRq+vUOS"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597E35E551;
	Fri,  9 Jan 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972566; cv=fail; b=YMEZngkl9AFQ+2jxa4WkfvbbJXi3f32h8OI0fNlxvf9dVw7u080DPGhOSwQoHixQdGQlDzB7l/qtJ5+Fy18yHrfhJzj6UrfE9xRDiQlUX66nw926i8iDDcT6AGiSXOtLaV6+BhGYHZzoTtnpqpu070QHgbBks+YT+wlWrPJhPCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972566; c=relaxed/simple;
	bh=aOAaA7jThMYTLvhiPxxVJZNwV14iX6s7QyAVIfn6T48=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tVXVYzulsyBMcUAxvVYb93J7/cI1pCdgFYXKEU+jkcC03fIZGFeCu4r3h6gWusOihW74OKnWX9E3iUEFRuM+0LAUQkdnTIOeUnasJjOEn2wndvMRBi8C8yOXt+jN90SduhRit3aW3VcvIRW+9t1L+a0za63a44Km7RGT7XxoJMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BRq+vUOS; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifq+/bDLmWRrlN1+1zApKu4yaVyDzqRr7vjbVsSWvpvJ9WdFhENqjh7y5IVriQfueXc4E4QcN+lhkbf/d4U6c8ViAppC3+H8lSWfXg+J1E+7HBEMoKY8XTa2Y20X1CFozKhkvfauwV0eDImTbNUHqolRs1Zb6bHsmRp0sB02YMHLRryyJ7OHsIonmc1VPSuA6ueMpLJ+DuE/PG1VERyJyTmXMW6iWMMlrvjs5ae+FScXqOSUs/t55XFT2PI7TUHr4YyPUOkaiaZGOO27VSCgdwYBoM1Gx5iV1uuR+C3eHmenIhjg+mE5u0nSqLU5IB7dD9QkyTEO1VB0eaDi7b6q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILU8UFmHXUWrFEnocL7/1SBQiZN/bilsyMgv0JmFyvI=;
 b=Bn2bVZhun+nXG/xnWzB0yFkatb2zzG72RctadvXxJt/s7pIm6wTRaFEbUTx0dOlIZDv61Ozi6QTkBFqvmj8rq+nNoS0ImGrHPJGicsmXP4ttDPuOvOcYjZLu7xbbEkTxdpnYJn/SNCcza/eYDJqWjAbJyomiKQGZI+sTUeiCM+j+nEvG0GRYjTbnOUNKcoZ9k0rT44aUkU+JDSXzOnTQaoC8gJNe8ipzM5PFLdddgmGE1ZH134+4kFHBnVJVLJ0mreF5/mYO70JW/NzwfmY3lAUgKfBlR0LS8pkGM575aUEdkQFRDeXZDJJheuv7mrL+BGU2Q5avMbqUlJcNf0Buaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILU8UFmHXUWrFEnocL7/1SBQiZN/bilsyMgv0JmFyvI=;
 b=BRq+vUOSt8XRTxqxZP3V9MPoK9W/Zs8ggLx2Elg7JdGIH1QwxV+ozqGHIxZo2FgF6Q9Vc1K9mI2omopC2Kh7GgT/U0khGN7HdQEo2m2gze6QK8ux243JsgfDqvG37ggcxTNeJMmA5TTl05dhohyW1N3tzP8+g5JShX5YVWENPw565W7DeS9atzquaRQ11+FCwSu3D0sphKzeXZ0qF7SYvwDh6ZXdu9SKogv15sptX25/TepPRQ1yCSf1NphHfZOK6pIq4jLZDpnMnXEFOEOc8Ix6N/AN8W7N33w7hX/EMKYAcPWk+K8eS1Jrswf/1GZ/LjzYbmz1s4Tvw+X/sDLk/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:21 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:26 -0500
Subject: [PATCH v2 06/11] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-6-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=6978;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aOAaA7jThMYTLvhiPxxVJZNwV14iX6s7QyAVIfn6T48=;
 b=DkTbVShCe2tGa/qNUh5Ra382+VoTCa8eS3kQZ+b9wJ6IvqLlXuJ5AeyAq+NL0qHCYXN+2xYL/
 92Pw3KRIOs1CZRYuVRcm0ZyWK1/vscpThF5x7UGB0WXIUSR3vrwiHrD
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
X-MS-Office365-Filtering-Correlation-Id: 74669a2a-699b-4f34-4183-08de4f93daf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25iUExHTmpaTkpWUTcrQ0liRUxzb095T3NCcHViakQzQ2UwUHJJRjBEaWwv?=
 =?utf-8?B?SlhyUFhOV0NRVlJEMEY0V2xvYzNtdHVRQkFCRC9EanlaVUVsR0cwNkNjeDQ3?=
 =?utf-8?B?MVI2WmZvSnJLc1UxQzF1K3JxTW5VMXprQW9lSWEzOTliVUhFamJrY1pMYnlN?=
 =?utf-8?B?OWh3TjRGNXBFREdnZ2ZpNm9lY003WFNnK2UyalU1QXpsbWxOMzNLZ1Uwdy9J?=
 =?utf-8?B?MCtuQzFKbXBmQkhuMUhhaytBWXhJL2xlbEs2YWlBQStMVDVOZUxTVXFINTVO?=
 =?utf-8?B?aHE2K0xVV3hnMDRFNXVYU2JQK0hDd0lMUDhzQU1qWU01a2VSc2gyVnRrSTM1?=
 =?utf-8?B?V0ZXYSs0ZGx1Wkx2K1pRSHIwVEEvSzhWdGZicE5OdlZEWkE1QTE2bDlBbHBp?=
 =?utf-8?B?dnErNzVZL0xGVENHUmxYL0xxWDYxdWRoaUVpRmxzZkNmdEhtWXl1UmdyV1lj?=
 =?utf-8?B?Zlo0RlI1VU4reFNoVXd6OE5WUWh4aHUxNU1HeUsvV0ZTUmtYVTNCeEpKa0NV?=
 =?utf-8?B?bEVyRjhKcUwvaVU3YW9qUWRyeGlSRWpKSFV4SFFhckQ2WCtHaFRITDJPMHEr?=
 =?utf-8?B?Q01keGkzSzl5V3Q4amcxb3FGWGIvRk5jNDIvai9ZUVUyd0FmTk1QWjRmdnl1?=
 =?utf-8?B?cmtVVnNOZ1ZJTjFxa1g1c0FCbmoxU29GWVNtejhPQk1JZlFpMkR5NUxhaUw3?=
 =?utf-8?B?U1N1NW1QYlhMc3g3OE4zb25lQThzd1FQcm1ENzh6VW5sMy90ZVJUTGJzczZO?=
 =?utf-8?B?TjVQa0lBZHZsY3FSSFVWU1p0WjNrZnhJMURWQzJFU1IyblVWZzIxZ3g4U2VW?=
 =?utf-8?B?WWZueS83VnZYblo0QUpwSUhUN0R6OFBkZEdIRnFOM0daZy9ETm5KRDdTR2Jw?=
 =?utf-8?B?dDBRek81UThXbE42dU1CeU55TGw0RC9Ua1J5WDhPUmhLWGRYdzl2WitpTlRT?=
 =?utf-8?B?QWJwMlEyQ0VXbStVWWdkSTltNHppeVA3YXVieUZlbm5XNlRQYU93Ky81aVhS?=
 =?utf-8?B?Tm4yNm8rczZGNTlwSnJCWEJyQWNObFhGNW05RzQvZm54Rmk4ekFWRS9jazRq?=
 =?utf-8?B?UGxUZlhuL2VBMFNpOUNJc0tNRFRiM1JpTzZKZEFtWEhkV0FMSDNvaVhyNXhq?=
 =?utf-8?B?amw4aUowOW82aXRpWUhSeEI5SGpoWUFTUEtoWmhkRWZVbExneWxscXVNMUVS?=
 =?utf-8?B?cmpCdHMwNlFqVzJqWHlmUTRBSW5FRytxR1FPQ2cyeVRXcXA1OTZzNVRkRHl2?=
 =?utf-8?B?OUJXc213dE03VW9NaEJDNWROazBhdGJLOUdkVkNBc1ZibWdCcjAvdHNqWTlL?=
 =?utf-8?B?ZE9KbGVNS2djUDFZSG1haVFLVEZiWTQwZW9TemRLc1p1dW40emM1QWJnclgr?=
 =?utf-8?B?dGpPMmF1MHhIUzlONkc5TU53NVRKblpZUWkzc0g5MmVPbUlWaXFkelcxRDdy?=
 =?utf-8?B?UWM3QzJFTHczZ2UwTkc5MklhQjQwYXlSek03Y3VwMmsreXEwSjhKTUcyRG0v?=
 =?utf-8?B?bUdvVWZDaDdsMVBvZ0NUcHh0S1hKMWF3OFpFVEhONWZEbC92S1RabjRXQXk3?=
 =?utf-8?B?QThpYXIxTkpXbXhTV0ZoaU1GMHJNQ2lDRkJ4ejlYM2lWdktjUTQyMkQ2SEpU?=
 =?utf-8?B?Nk9VcGM3R21Ic2xtZlhTeThNTUVSMkRBcWV3aGp6bVIvaHRmTmo1WEx4TTVM?=
 =?utf-8?B?ZFhyVUFGSlZadjdDWjNQZDRob0QwdTFoZFpqUllkODlBZXNDenFVYmVOVWhF?=
 =?utf-8?B?MGhqcUJMYnFubGJnZjhQQVdsdXJ2aXREeTU2a1N6K0dseFdrU1JyWkJ1bGxO?=
 =?utf-8?B?cVJWWk1ZUlUwcUZLd3FLSUF5OXNPZldlMElGM3dxVm9XUHFvMEptUkFnVVlH?=
 =?utf-8?B?VDFVVHM4dUxvcms0NGZRd3Jmekl1Yy92bWJ2eXVXOVM3RUhQRUlLV2Q1aEVx?=
 =?utf-8?B?SjlNRUE0a0VQdDZXV0daZUUyUmQ5d1N4TE5nUHRwVHVTeURyVXZqRUlKbTZJ?=
 =?utf-8?B?Nnp4clluNmxROG9mNW1QNUphM2M2SW5ZelNmR2dxL0Mrb1UwNnhkNjNPaTFj?=
 =?utf-8?B?dDgwbnMwd2xLYzdmSlFReDdkb3hoRm0vNFZ1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1F3WmFPZHVnREk1V3UzOWplUk84WXJnc1VnQVdPSEpYZUpLekxGMUovbkl2?=
 =?utf-8?B?bGFWVy9OR241YWYzVmM2YUNzNlBIdjBSakllbGdGdmJwUzBySDVwQ1ZLNW1R?=
 =?utf-8?B?OEtEMFR1RmtTOGFtRmhubGNZZHlxeFBlUXJsQnZsQ0VDSTJtYm5IZUxKeHRC?=
 =?utf-8?B?SGhZMnJscE13QUIvVjl3MHlkdjl4YUhSZ2ZubzRMM3dkd3dkR09Kby9nQjVS?=
 =?utf-8?B?OVJpYlhCVENBTjNPdEZJb1N5ZzNxcTlCUklZOUVJR2RiRjBtL3ZnU0MrM0lq?=
 =?utf-8?B?TFpPTE1tOStrVmh3akpWaDMvb0lnSnFIemtQMGt2ejlVZ3Z4Rk1YTWJ4WkZk?=
 =?utf-8?B?eTFObEpBWkdBK2lCbzA0K1Bydkh6ZzQzaG16aTYvbGd0ZlNIZXNoN2x2dC9F?=
 =?utf-8?B?TXl3VW9URjhaSmxCdjBtNVNOT0tUNGJwZXVuT09lTzQwV25wUm5lUTFMeU1n?=
 =?utf-8?B?WU42endxTjZ1eG9Rell0UnJUdFJ4cnpmdEhjSzF3NXpmNEE4RkVOT0I2RGZw?=
 =?utf-8?B?MUxDdDZDUFQrWDVhOHliRG40eGh1cU1WQmlRdlAvaWMxTkR5UkVOaFRCUExl?=
 =?utf-8?B?QWlla1d5eDlYWTUrNWUxczNHRnFVc3FTNDk4b1k1TTBNbXVCVExGZTZJZG9v?=
 =?utf-8?B?WnA1eUd0NjhpQVNOMnA4RnhaZVk3YU5JMFNETWRSaEo1S2x4YUx1azE1K0ZV?=
 =?utf-8?B?QW16dzZDSXpMMG44dVFkOGtPUUM1bE9XS0hheXliMUppbDFKcnc5Uld3WlRq?=
 =?utf-8?B?dC80dHc3a2NPN3lBMFo0TTBIS0RlQVpHQkRjYjZnVVlHTUY1Zmw4NTd4Y2Nz?=
 =?utf-8?B?eHVLcThWSDVERjdtSWpnbGV0OFN3STBocWlwbkI5VHpra0VQeWJBOEhlbS85?=
 =?utf-8?B?dDF1NFJPdlkxVTlwd1VnMDMyYW1qZEdReWxDRlpMWkhubVpVZngzYlpQQkF6?=
 =?utf-8?B?WGRJUjhIbllNUk02WEs1Z3dPYVNjRlhsUE8yUEh3ejUwdGxJUlpOdHJBN3Ny?=
 =?utf-8?B?TkM0VlVmTlFyWDhmR2RwOWgwYWkwcEFwWUplOUhtTEJ5ckxkWjJPSFZoaXVU?=
 =?utf-8?B?Yk5WRytHZzU4cVBmWFBHQS91cWE1ZEVhM0VvcEE0RURHUzJDZkdSVlkxQkdJ?=
 =?utf-8?B?UDFDRkJ0a3NDc2N5ZG9ucDVGakc5cTF0bHErSkkvY2s3QUJJNlZBUzVEMDdX?=
 =?utf-8?B?aXR2QlEvS2IwVkVtRW1WRVA3dDRmcE00VS92dGF6MFVvUzRNN3JBeTdpaFNZ?=
 =?utf-8?B?aFdIL214U1JDcWJENVBuRnFsQWF4MnBTK3JLZnppOCtGUS9HR1hNbm45OCtR?=
 =?utf-8?B?Ky9rdmk1Zk1WQ1crblhWOEFJYU5KdzdJUkZ2Mk1hSWpwOGlDcDRXZzNRUVRs?=
 =?utf-8?B?NWtVN0xUSG1rSkNkRDhvMk5YazhNLzNmemxtUVExWUN0UkdmL1N5QkU2aVEr?=
 =?utf-8?B?eGFFcTVOdStJYlo0OUNFRVNleWpQaEdTUWs3ZTBuaU0vQ2FXdW5VQWpUc3pi?=
 =?utf-8?B?eWhIK1g1VTFNQXprNmdnWHJWZ0NiOThKSzRicnV1cVoxRkcyNXZ5WEpQRWlM?=
 =?utf-8?B?RW50MWY5d1p2Y3dwTEFxK25OR2JGZTF3OHdaNitpOGhxdWh6ZkRVNUMwWExF?=
 =?utf-8?B?RmxzV2l0a0lxdmZ0bjAvb3l4RDNZQ3JLMG9IU3NuN0xqaGNiY2RyKy93dFc2?=
 =?utf-8?B?YXRXdnNySU9qc1lmM1JWMm1HT2x6K2lzMXJxZ1dtQ28xVU1XMWE2cW15eWpn?=
 =?utf-8?B?WU8ycFpabVBIMjJCemFNL3pIdVNaNXJNeXRBSkpIRTdkUGdxcW9NeTkrWk1N?=
 =?utf-8?B?Vkd4aWFoNkc4cTBtUFR4STNtdm95N3RZL3YweTBWNGJwaW1WU0tYZzg4dWgv?=
 =?utf-8?B?YVFSY2VlZ0ZMQUUzN2tvNk9tZzFCajB5NjhJNXdNbDVaMFY5VEJzM0QzYVVV?=
 =?utf-8?B?b0dMdjBveGJQYU5DRHJqNUg4RVdJM2ZKdWM0ZG8xOVlDZTF5VHVWWkFmV0Va?=
 =?utf-8?B?SDU5SnpXaS9zQzFtNXFMY0FoejU0MWt0cFVPaVRBYUFLLzhqeWtCbnBHUW5z?=
 =?utf-8?B?Y1BiSDhWR1VxWFlJYVNnbHJ1Tk9GakVyR3U2NEI4c1BNOFRhSUN0QnFoWEZk?=
 =?utf-8?B?OEhUNG5ZV1JVdFJ1dFg1TjdPNmpmOVl4YS95NjdBa1B5RjkyYVhNUEdva2lQ?=
 =?utf-8?B?U0NubkxEOEJFUytzS1k5NnhzdkxiaGx4a0FHNHZkUGNmZ0xWT0V1VW5sNjJI?=
 =?utf-8?B?V2JEQm5Yc3o1bTNSS2tpS3hVMmRBblV5S3NjNHN3OENpMlRxdG1MT0FXMStQ?=
 =?utf-8?B?L3k1SEVRUUdBd2YvYVlJSTlLcDZDdTNQZTZLWEcrbU9qNWhhRjE1QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74669a2a-699b-4f34-4183-08de4f93daf2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:19.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyMKX7z394WBCfdUqoj9967kUhdt76Co9I208i/gEe8jS9gQbolsF1f5zB2zQiial6G2DowVcPo+wXiGu6S3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a1656b3c6cf9e389b6349dd13f9a4ac3d71b4689..79265684613df4f4a30d6108d696b95a2934dffe 100644
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
index c12cc80c6c99697b50cf65a9720dab5a379dbe54..27f79d9b97d91fdbafc4f1e1e4d099bbbddf60e2 100644
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
 
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.34.1


