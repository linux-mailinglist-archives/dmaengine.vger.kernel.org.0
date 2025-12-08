Return-Path: <dmaengine+bounces-7536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61BCADD76
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D51309F813
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAD28CF7C;
	Mon,  8 Dec 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fo+VFnBD"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52C2D5959;
	Mon,  8 Dec 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213830; cv=fail; b=kvYYF3pbKLFXCR5xpUs19iQPxyBBJUPtjLOuFETZlSBXr7H6+NBqY/fW+7eervnSzIrvs4+h1TaxgwfvjroIJV30FHk/ee4X59qkU10qkZWYC09UU/UU2JeHzlV25VnaLTke/NBC8qu9Ufvutz2iSwzbt/yUOjDyqY5p/lR9Ktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213830; c=relaxed/simple;
	bh=7ACSMs+LlCxZJ0E2ph5vAYdGsyuBfLN/CnG6jwggsxg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=goC0SNtLrE/aM+oe5rcG1MAce+H3NrPnQX+Wzvk+bQbErFZ0lz9pVosIQppRgrnnXXBEhqj3bTpnOteLZI6tfIMHBPExSSt/GM2RuDtgh9NAH16nM5HGOQ4OToKyHamiR1iaMuVb/vokgaseOGXGcQE/iHXmT3zLhWNq5F/bWm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fo+VFnBD; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4sfqV1zXYF/jAKPMYKq8yGYE0dGXcO4GvnVuOjuZ9wbKD+MbAbOLjhqQMi2ZkZVevv8Njq8VIZHETEE08qCOED08t1ErMu5sD4rETt+/xy18r33+3bBvQw26qn+1dBEtpyJUloDmKozfyPqpQX4lzvBq7DyUNN1gFULglgxKvjO55f0gA8Jvjd1uN//bkouEcUWwyV0EGaJivuCA1TUYcJh3QWb5h9uxgBh9YlFtgbHcbJ95phQN10OsHw9AkXn5NsUMzUUeHq9hus8WjJYq62XEYcwGXcoCeqS4WFAOzvseWz/Cyc8F+GSw1rRvuQ23Hz530icN7SJt1VoAWIWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTe1rmEctX9g1htj33Ox3t8gl9iFs1y2sMcNYI0dwcY=;
 b=jXJCLs/qy9ocjknmecDYkNJkNge0jciBlKS7xYOuKD+b2gWI6WUlqO60e1b75Q2pVHuaz64E8zRSy1MG4TSeWt54k4Cg0k6ABOeClgdhrIdAPudq9DX+gxBhElj+t+KWlkHiEZDcoVYEX4CCOKhMyZSHSMPXpkBMbNyYvvUzm9AzpHgvLJyBrFxp3DCaFrTThP5ZkLFZK7xQPHx50GdVc4LtzvgoBHW1YC3rcFB2ljl4LauJYQc+9gUfBScgMNvHCUWFds2P+PdfKAU2zx9oAh4btp9+yNSfhJkaSMANnpcorLzn/aA3OyxeejH7L8xg5oROAgw5jtTesCeucUF+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTe1rmEctX9g1htj33Ox3t8gl9iFs1y2sMcNYI0dwcY=;
 b=Fo+VFnBDuQlnd65QucjSu44AR6nwsWAsDxq/XF1jWus+Jg2cI+QvVkgcBVqCnfW09j1UVLLamy30JoKGRXI5vu8Kgoa4bEFLLto87Ezy6FznOcCda/wGuX3qcTORbYMf9UZ2soUALGYzQeQozWd4f0kWP02yDgwSjxm7bc9zCAhA+XQK3mUOAmIfdA5zqoJNNsQVulanMCIj/HbQGuFFHuZjdhDYy5V9ANSCk2ezpuE5roKMEwjnH893WaUa/TDIPPzBpJ1dmoNucYA2/s3U2VjGta8MqDDRj3ilUJOUSbxnAYhF7ijGZxT5xS1Ed86Hg5oEzKXKw5+qUEPVGU/Siw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS5PR04MB11322.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:24 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:43 -0500
Subject: [PATCH 4/8] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-4-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=2844;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7ACSMs+LlCxZJ0E2ph5vAYdGsyuBfLN/CnG6jwggsxg=;
 b=D6YSAb73g7BAXLbuNHXd7Zo+85nJCxvWnEfBS5N3378w1S794TCihXRI3MBsSG1WqQxJlgANn
 t4YDJMqp5kkAS7KP+iV3XwO4ZVigZTJhGcJhf55kkiXJOKizautii0G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS5PR04MB11322:EE_
X-MS-Office365-Filtering-Correlation-Id: 70227184-2c6f-449b-8397-08de367cacc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGdDOWVPTGhPeTVxenA2eUZhTDE2UG5kbHFYblBJSEwwL2k5M0FUc1R2Skkr?=
 =?utf-8?B?cGd2dFNGa01mNG42L1QzYTQ1TE85akxQL3dZTTJPQ0lzRFBkcmFJL3pwYW4w?=
 =?utf-8?B?dHBrQUZiMEg5NlZUN2Z4UW9Lekd6aGVqN3JFVSt5eUF6YW5DaVFDMnpGeGpW?=
 =?utf-8?B?ZjdqZmFSTFRNcXdMR1B2TzN2ZUh0L29weTk5UDU0TkZyQTZjcS8vQ2d4NlZQ?=
 =?utf-8?B?anJpN3ZrY1BvejBCK3ZsVHQ0VGdubEZCcnU1R1E3cDBKcDYxZ25DTkR0TXpU?=
 =?utf-8?B?VUM1NnluckcxUktPbmlBQVA3MmN0UmtLWHE5L1F6VC9RWUJUWWVzeGl1YXZP?=
 =?utf-8?B?UWlFSyt2cjZ3b0E2dHltbGxNOFIvc2FTQlRpTTF4a2JFY1VYVDdGTFl0VWRI?=
 =?utf-8?B?VjlYNFFZb3dHYnRma2YxS3E2QnBVUDlvUHZWcm04L3ZjK3BHOFNhaXcvZk5t?=
 =?utf-8?B?eUNiQ1M4dXU2ZmhiengvVTUrMktJWUhXdXFFbGd5UW56Slhhcm5zemR1WUYr?=
 =?utf-8?B?TDhDVUg3RzNFNzBqdThwQU1kamROZVFER1dZMnNCbkJNZitDTUViWWhmZjBw?=
 =?utf-8?B?eXlkVkJXaHBlc0pYa3haUmpPQUVRR1g2N2tEOE9aNDAwUW4wV0ZvNFpRQkp5?=
 =?utf-8?B?SjNZT0ZyUWhKY1krQ2lwbk1UL08wODV6Ri9ZR1U5a2d4ZTRCVExzM1NibVhF?=
 =?utf-8?B?UlNiSHRHVGVTZkFyVnhaQS9NTjhWUnZyUnl4ZUNiQ0lJSytFTjVoWTR4OHAr?=
 =?utf-8?B?M1ZqSnRxeWUwVkFyQWNJRkovTGgrcmlicVJVVE5kZmJac3N2WlhBNy9JL0NE?=
 =?utf-8?B?UytiT2hTSnB6NEIxbWYyalFROEg2SFBHZGhtVkZZQ0Q4Ynd0VnphNXBIQlpQ?=
 =?utf-8?B?ZDFMU281em1VYVIyNDhnbm9pajNINUR0dDVZUWU3WTM4cjlkRHRLUlRxMldM?=
 =?utf-8?B?ODB0UXU4UTRVeTdWWURDeGpRbis3Q2F1SWNyYnovRWw2TEU1WmY1Zi9ZN2JU?=
 =?utf-8?B?Z09KcmIvdU5adnBCU25KazlxUS9xL2FQdFFBcXJGNTZGSmQvdFFFWUtISWRq?=
 =?utf-8?B?SWYwYVdxSWswS21MdFY3aUcwVGJ1TVFxL3BQdlY1L2Z2U0hYKytTbHVsNnND?=
 =?utf-8?B?enRXanpyQ1RDbnVwd3poclA3MDVSUGgrK1NaakV2ZVFtR1pDeEhYTnpEVlZ6?=
 =?utf-8?B?YjVCOEtXRWRIelIwaFlrUlBoN05BNHFMbUpqdWNVbjZmMmU0ZTN2Yzl0ZGV5?=
 =?utf-8?B?aXY4RE8zRkxNMlBEcUw5eUwyZjdxZnpCMHFVTmNiQWlhQk4xOWtqQ2pXK3Fn?=
 =?utf-8?B?b090Q0VwTmJIa0R3YnJDOUFaY1lkMGlRSHpMSkQveDJVcjdjNXAvUHFCaTVV?=
 =?utf-8?B?Ylh5UGp6Q2ZtUGVaSWRWQS9ia3p0RTFnS015Mk1EL1Nqbk1mYTM2Y1I5eUlB?=
 =?utf-8?B?dXM0OENCdG9iNU1IdU5Fc0QwQUhSVE1lQjhJT2toOGZjeXZPbEwvaW1IWXhE?=
 =?utf-8?B?cGEwVVptRm5vZjgzRjdjR0hrMXE1Rk5UT2dFbXpNelBLY3J0eGxSdmZNWkVk?=
 =?utf-8?B?M2hTeTNQRFpMTWkxQStmWitNUW5WSUw3NEJud05zTDl1MDk2NkppSnh4dkts?=
 =?utf-8?B?K2xXTlVCREttUzFkditRWXgrUktGMTlxTmYzWWY2aEp1RE5FYlVlOEE1VlVV?=
 =?utf-8?B?WjJPaXZqOFhFMDVOd1RVUnJqNWw2ejdraVduWmNHWEdncTY0aW9GcjhYcGM5?=
 =?utf-8?B?WmdVaVdSYUhkdnhqenFqdnllejQ2c1dLUkdOOHM4aml2Sm04K1N2WVE1KzRC?=
 =?utf-8?B?WXZnL2p4MXM5bjJ2VWFwQjdwdCtOTlFxdjB5RUdWdzU4SGY3dU5YSGh2KzVP?=
 =?utf-8?B?S2xnOTlGWlhNaDBoMGxOR2YrbnBGRkxkVEVaQ0tJb2ZaWWp1Qmo4K3o3M3g5?=
 =?utf-8?B?cTJ0MHczbHpkNzBuTWE3RXowc3didjBidTZqbjM0R2NRTkdtUW9TZy81cmpX?=
 =?utf-8?B?cDhtb3pZRlAwcFd6YWs0b2R4Nk1UdXloL2pDTFptNEgyang4L0lsSUY0Ym41?=
 =?utf-8?B?NHdrczlZR2p1MzRCYmYrbEVBUE1WdmVRQlNOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1qb0wvTml2VElwdExObzFOMVgwTGxncmlJZFMxQ1JsNFlIeUI0eERKUlE5?=
 =?utf-8?B?d0RCb21aYXBicldGMDhBKzlTTkx4aDFhNTREWkVxRTAydVFBYXR2dzRPc3Y3?=
 =?utf-8?B?Vjl0MXlsUXgyemdXcEd2QWQ5YlVNU3RwZFluZ3ppODh6Q3JjUy9MakNHc2dR?=
 =?utf-8?B?UEw1ODhGYU1hWXpHRGQ5NHB4UTV6QmlDMy8vUE1uYlBlbkJ6YnlmZEFCa2Zn?=
 =?utf-8?B?dERSc2hXT3hEMjRRZ29JczRXV3MwenNIbS8reGxxZ2Y3dGgrRWhBLzExSDJG?=
 =?utf-8?B?cW5Ma3UxRUNxcFdiancydGJGdUVxMUFnY2hxWFhZWHVTVHpJYjVreHljS0pn?=
 =?utf-8?B?NlByUHdEeUFzWWY3S1FWdmQ5VTh2cW51dEQ3QklvTUdqb3grK0JtUkdid2Vh?=
 =?utf-8?B?Nllsb1A0UnNlK2xXS2NIeEFHdVhZTmJjUGdMb3NKSjBGZC9qdWJqOWhWTExq?=
 =?utf-8?B?aVozdWtsQTdUM3FVQXVDS0tDNDNXNlBxcXdwUzg1M0hGZ1NKdFo1d2V2K05V?=
 =?utf-8?B?Wkw3UmtqQnZnUHBnWjg1WnNwV1NabnhQVU91aW9pL1FjSUV3dTVMNHZDb0NH?=
 =?utf-8?B?bjA1dUpNcWRidmVUdm1ObEZ6WFc0WEdWOGMwY0RWZFU1bDFUeHF5YXBsdUs2?=
 =?utf-8?B?VVp2NlREbTRUYUQwMEJmR0JWbG9hMXJCbGJUR1BIZUJxOWg2VCszcU8ydmN5?=
 =?utf-8?B?cXpaVlJYcmVwa0RKb2hlRUErMnlBRGh0N3BicEsyK04vVFNVc2svM1hqemdj?=
 =?utf-8?B?dUIyWUw3RDdZMkc4bG0zUlJCRnkvYk9ma1NFcjNUVlIxU1MwWEJtWjVFNlBs?=
 =?utf-8?B?amgzdVpwUWdRS2hBLzlkWHNkcXA3TEgxMGNpQk5hTVA0S2QwZm1nVjlBZXly?=
 =?utf-8?B?T0paNHZNbnpZVEtwWlBRdzR2SThnSUxWS04zaTdZK01jRFpocnJSaXM4c09x?=
 =?utf-8?B?Q0hoeUhjT1YyUHZTYVhVclBBNU5qV2E1Z1lzRFk5UDVReFdheSt1Q0wxcmph?=
 =?utf-8?B?RDY0ODRZenZBUHlmZ0ZWcWVsWFl4S3BzcXlUSGh4S3dTNkhoYklmaXV2UVY3?=
 =?utf-8?B?cXRqQk9zM3pQU1E5d1FyR2tmTGpFWEhDNzFjS0NHS2ZoTXBpNDIxSXRWcGpS?=
 =?utf-8?B?TjNGREVqV3NnQ0RxckUyRjdwWFNsU0VmSEpxWWdZdDhFbjh3VUM2RG83L0x4?=
 =?utf-8?B?eEpMMFg5TTYyQUVVRUlCa2cyaTEwZVYxSno3SllVTFFseDkxQStUYWwwNU5r?=
 =?utf-8?B?azJ3elJ3djZ6VDRFeGx3NHVTeGx4SWRqNkpJclpSSVhaZ2MwT3hSaWtvZklE?=
 =?utf-8?B?WEljQkhMdXlqMmM0eU5EeEJpTW9PMW10WTcxZC9qYVVsb1pDcjZOUTJGZWpv?=
 =?utf-8?B?ZTRZN2Q3TldNS0dVMVZmbmMrWEx5Z3VMVGtyUDJEN241Vy9MN0o0RmhieWds?=
 =?utf-8?B?YWZITCtGSXdGWGt5RFBtWnVRZ3dxWnNEWjgyY0pXU3FMcWRSL3pGekxiTjRN?=
 =?utf-8?B?VURCVU9WNGdWN0N2Zmc0SkU3MVNzWmc5YlN0N3FXbHUrZ2xUWElERW0yY0dh?=
 =?utf-8?B?NWNQRS82blUwdnhJYXlpQUh1NTNDWm1Id2wxcGRRMWpQNmxoQjhOQXppbVdI?=
 =?utf-8?B?WGFQSGhxZmF3ZDI3ckxEcXBJZzVCdGNSc0hnOXdwazd1MXA0SkhRbTlsajUx?=
 =?utf-8?B?SmVINkd3MzQ3RHpZTXpENFdxL3BiWHR3QUlPNjZmTWp0VHowa0t3ZWpJODMr?=
 =?utf-8?B?dkZVcW93cnpSR2MrS0lObUo4NnRSK2RScUd6Z09vTGR3YXZTNHVqS21qV05X?=
 =?utf-8?B?MUNoeUhWb0h3dXJpQVhMZ1VaUEx2eWRybjdTeWs2YlNmMGs0bXZBUmsvREJB?=
 =?utf-8?B?SG1TT0IrdCtCejJiUzNEaVdJRUlHemNmQXRxWFZ0WEtSMzVQRTFjZHJySTZZ?=
 =?utf-8?B?cVVzQUhFOUtHVlFqSFpEcHpDNGRYYndNV0hoMnZHOVoyNTMzY29LeVZmeGJ6?=
 =?utf-8?B?enhhZVpNQ0dBVFp2OG11YUY3VzFLMHhxMCt1R0RZNUtEOUwxbFRrNGhlb0Fk?=
 =?utf-8?B?YjhsR2ttM0x0cmNTREJzZGJTNEQ3OExCRVBnY3RqbmZOMlJUbDBJbWZtK09W?=
 =?utf-8?Q?MWCIBiY+OmcAq9W/m06eJauGb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70227184-2c6f-449b-8397-08de367cacc9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:23.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4OSoJv0WkHupdP6qgaD6QGbi7n7dpzhmwRTS+voB0HsApOW5bXZyhyXJxfpYHTZ/2Xc4aCQvYNd56THWg8O9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11322

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_slave_sg_config().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 58f98542f8329a3bfdc5455768e8394ae601ab5f..744c60ec964102287bd32b9e55d0f3024d1d39d9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -230,6 +230,15 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static struct dma_slave_config *
+dw_edma_device_get_config(struct dma_chan *dchan,
+			  struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	return config ? config : &chan->config;
+}
+
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -348,7 +357,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+dw_edma_device_transfer(struct dw_edma_transfer *xfer,
+			struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
@@ -427,8 +437,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
 	} else {
-		src_addr = chan->config.src_addr;
-		dst_addr = chan->config.dst_addr;
+		src_addr = config->src_addr;
+		dst_addr = config->dst_addr;
 	}
 
 	if (dir == DMA_DEV_TO_MEM)
@@ -552,7 +562,7 @@ dw_edma_device_prep_slave_sg_config(struct dma_chan *dchan,
 	if (config)
 		dw_edma_device_config(dchan, config);
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -571,7 +581,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -587,7 +597,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.34.1


