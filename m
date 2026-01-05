Return-Path: <dmaengine+bounces-8038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A3CF5E3A
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C609C30F2708
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6F275AE4;
	Mon,  5 Jan 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R8GZal5l"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E28725F;
	Mon,  5 Jan 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653263; cv=fail; b=enedCrXdusnF+cnC/mw0MuXXfmCoilI3M7N/35aqy01r52Y9VZ6w39f0+ReKqukRWzdKv321f+Sc3eAETMIFuugxh3DTHZagzXc0msTqkBEpfdr3GME4Mik9ST1+WZm54K64g8LrlGi0ENA3+vxbW5p6B0+6Gre3uglhYGqLxfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653263; c=relaxed/simple;
	bh=666T1YwSFcJwi9nEGWpzaF3VPuBgm/U7tyH/YWn6ft8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rrVGU0yXux2458/I7EtuA0oNciS75tA9n4sq8XYoxUngD1riBpv91GCCMEEpfKMwEEeib/n19WvlqGp3gBrWb4k8iak36qdCDAOz6Fz9l2hnHp4OGDEM5mylvkj6DHsgLhnW1oCsqKuqJYk+urL7JF22cVL2Nf2fdntfwNxnDnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R8GZal5l; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7xopmJCRTWd5jEi9nA+oLrc2yL9VHEMnsqvlhh6sJ0+yvzZ3yY4ZEoZADZX5Ele4FDoKcAAOCR3MSOthM5CSIrD/IFD9ItPqEnpdfXUyUW8MHHCdwGXMZeR67v7ddr8yYSs0AfsBZ1brrgWir2KF3mR6YhXpjUrvRstNn3yvblKY6VaG3+6wZq7CNxr82wBP7k9sbdZpjh09TjUOWiC7KEgDM/nKEbH9sCXfoQvq6HT9w6ymSlBUU8Vp8vPJlkdCqsr0xaMN4SwRSVvMUY7c07TQZASR1z7RjDt3t6yGORQ/ouiLyh8+akTqyfyAhn2Ym/LvtjoiOjn17oJ+kj2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdJbVboTE217eM5NUnlyygHmPDtiBWdhUTcYQkIUEh4=;
 b=H3E21+fQHfS5VsHu+1d5L94cnOg5cTHoSsjqxNx16pLJlrNLLHnXx0BaOrqrUPMH0/06WzC46JJkiJezXKtAddyDesbqM9Kp5gx/UBw52NK8f/XZxIscz+WQAh3mvDvJdPg6gZVg2KmAIEP7v4a0D2D1mv27EDpqDgRQC7SaPk9hjb2W8nP+UNYoCZs7BKFBubQ62zWvxZeDFR0e0CxKlBBh6N4t1/IoNwyxHuL9LZ6yviDJB5sgiDIN7x6lm8hiSme+Evq7b8/bkPiVhUnM/TkYXIMVKefT/L5mOWXIBkme3jPHEusmZwdtk0hGwxCuMBaQPlI7DJ/eO9biihn0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdJbVboTE217eM5NUnlyygHmPDtiBWdhUTcYQkIUEh4=;
 b=R8GZal5lzxhYp/wIZUmhIpeFPHm83jZd4NMNYpBPc8pXK54CXdw5w6CR7qnXDIyI5+OIalWtlWCJuxJtKtvma84cIlQUJMotqBcl/J66FDuS2BSSC6wjEZ2KDaEUvufx8/engBdnzI+y7+90O0SpZXdOLl2Tl4VklB3vpOlz0JxUeJnhbsZIhvxW6L7rF9XzFNrgPg/tYhoiMB0ABZyX47nM9zpL46MGDpCiw8aTsOoPmt8O3rnLZiZOozTSdlirV2M0R6wjSfgSwCFjJjeAgcmhLDNznl0wybHQQp3YHscGBZMIiGhl8O/D2L5ndgeeRgXd37XiRjoBEVT0IUywoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:39 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:54 -0500
Subject: [PATCH v3 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-4-a8480362fd42@nxp.com>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=2157;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=666T1YwSFcJwi9nEGWpzaF3VPuBgm/U7tyH/YWn6ft8=;
 b=Ydl5vNmX+/R0BUkf8BCqzb8XiaN/77Nnh087algaJwzJAGFd4/WY1+fPD8iriHFmxc3sXNeyI
 /EPZc+R/8YXBnoAxzwLuunF8LLVDyZ2eh4SJUgxdOz8rY/0/WNZPGuL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 46111ae1-b065-4d34-6cc0-08de4cac6da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEo5SHpxTldxeExvR2dvalhqcUdiKzgzQ0RwcE1MT05PUnd0OER1Vkd5eCt5?=
 =?utf-8?B?K09HdGw3bHpuQnJsSGFMZGpyd3U2YTlJbExyZlJ6U0FWNG4rL3hlVFh0RzZS?=
 =?utf-8?B?aEFWVzBmTFpCamNacUNiRU1XKzBFRHAwYzdldU1Oemc4cmRBZW05QjFQSmEw?=
 =?utf-8?B?ZzdyL09TdW1JVW8xaHluYkg2L0RBdDJxc1lNMlRsUGVaLzh2MDdIKzJBS3Aw?=
 =?utf-8?B?WFdwWnFMRWQ3a2o3M3pkMVRMWDVyVTZuL3NzWW1FTHljSFRxMmNuY09Sd1M4?=
 =?utf-8?B?eXBDdTVDZVg2czJ2MklrOWVja0hlclpXeU5tY3RrZ2t5cHdLeFJhcDFIZTNy?=
 =?utf-8?B?VXhiZ2k3d3pVU3orWjdLY3BsU3ZPU2ZRNzg1b1N0L3F5STNNY2kyNWhnVW4z?=
 =?utf-8?B?Rm1nMVJnbFFJNzNoSkxuTHpOUmYxVzVtaXVIYW03WERBNFRzYVIyZGp2czNZ?=
 =?utf-8?B?akRRUUNRakNTTENQOWQ3NUFVNUl2VXYyb1g3ZEFLTm9tMkdKUWhEbzZiRGRt?=
 =?utf-8?B?MHRLT2NyRW5uUkt0eEZaa2JtZDV2b1ExK21pMkRVYnZqOHZvcWdKaUpvY2JJ?=
 =?utf-8?B?RjBsMHVTVDF6V0pkOHU1blBrVGUwUEdZakVtMEV3SGtiSWo3N2pBOFR4WWt6?=
 =?utf-8?B?VEMwa3N3Qnp4bk15SSsraVdOMkk4emFUc3ZoTi8xbzRZYmMvVUJEUEJlcVhj?=
 =?utf-8?B?ZGRsY0VlWjR3cnBsaDgzM1psYm00VW5MU2F0dUxMaW5Cc1NjNjRwNkRBOHZM?=
 =?utf-8?B?ZlQ5Q3pyaXdRdWtvT0RxTEZoYkJNODFGLy9PN09kWmNVbnJkNWFYYTBwNVpi?=
 =?utf-8?B?dmhndW1tU2Z6OVk3QS9TUFpHd1lWeFFpS3VrYlUrMy9KUm1GL2NKaUdkMVRS?=
 =?utf-8?B?eHpzd09MU081TGZDclliZ29FQzREcHh3TzNwdWlXVHpwS1llOElTVUs4Qng2?=
 =?utf-8?B?azhZZ3NOZ1lYUzlwdDFSaWtpbHVpaHhBcWVRU0JlcU1BK0VqdmRJL3ExWTFY?=
 =?utf-8?B?WVJXNUZuNjh2TFdmTGNiVys3ZW5yVHhKaXJvUmVsaGI4bitKY1Eyemc2RWM3?=
 =?utf-8?B?TVdpdWRkTVQ3MDlyS3FnK2JHZ0I0U3BoeERzQXFncVJWdnpENHlxRU9jS0h2?=
 =?utf-8?B?Vkhzb3BJeUxQYkdqN3Njbkhmbm9ZUDVEanlmV1hvaXhtNjFJU1Y3aWNBWis2?=
 =?utf-8?B?a2tkcGFzMG15Zi9lZGpvQy9oV0doVVRXZXNlWHBLUUZJZVByOVIwZTVjU3J3?=
 =?utf-8?B?dGM1SVViS0J3Mm5kb3pyRjlCM3QyeDhDNXFhSmdJdTllS2x1eFRRSnp5ZWFO?=
 =?utf-8?B?RE9POVF5N0dURlJBbjJSOTA5SkRobTlJRFg5Q3pMeWR0WGlrb0xmYXEyS0Z5?=
 =?utf-8?B?dldPQm9tamdzOFpsUk5waWJuaG9mQ0JlR3ZNbmpxWEkyUWNZem9HRkcwejlJ?=
 =?utf-8?B?K0RZU1pXK285eDRVcTd2SVFaMEl1cGRXNVgxa0ROL2tUSmxDYXBQdENDdm8v?=
 =?utf-8?B?eHl2RXc4OFI0M0RDOVZOWmhCM0ZXd1crRHpvb0prUXdabzhmNHA3YVU4MGJ2?=
 =?utf-8?B?SlVJQnlMSndmT05lTWNDYTZ2Q0VHcHVCamJMc3BnRFJZT1pGQktEN2VyN1pD?=
 =?utf-8?B?WmVrakdBaEsvV3hoZWVqNi9JV3J6ODc1bHZQckw4Q1Q0ZElhZzZGQm9kVW5h?=
 =?utf-8?B?cGhPcFY0NW40ZlZnQXFndGpKZmhIRlplTytwbGFuV2pzQ1dWV0RhaEl5Qncr?=
 =?utf-8?B?YzZBZzJLTHdUN016elBwRzByVk9NRzAxSDIwT0FQRVBVcnBFUW9YTnhhNjFu?=
 =?utf-8?B?eDFWSk1sYzZIK21uMCt2dXFvdnlMOFkxRGRFdEdwdlJvb3M3M2RjV0x3WHpt?=
 =?utf-8?B?VFE3WGVyVFBZcnZzLzh4Rk1jNExBbGpoZ2NXbElXWk9ISEFpTDRPSStBWmNa?=
 =?utf-8?B?R0FpbjVpYTgwdUxrSHMrMGdEcjhlNHFmem4xSVg3aU5MMUhhQ0g2RW5aY0NY?=
 =?utf-8?B?VEhpejJrazJhMkoxN3c5MVNMTWxVL3NwcmpZU25QOGplOXMyTVBjUEFmUjR1?=
 =?utf-8?B?eU1oK1NIMzhrWmdXWGNLUkhjNzgzd2pxYTl3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy9LMTRSc1IremJRMEhkZmovQTQ2am9WQjZjS3Z1R1ZubWpmS3JKNzdTWFZL?=
 =?utf-8?B?R2t5cWp0MjltZTlrRUlUb0lrMng0TDl6Qlhtd1VrdVBseVdJRlkycHNVUkpC?=
 =?utf-8?B?TXp0UGhObm5lQjIzWnVhRUljb3lieHhmeGZaSzJhcjIwMFE0d1JqdVd2T3Ix?=
 =?utf-8?B?SEcvRk1zUGRHSWxUWUluWThRZThrTFZEOXRESlVkVVNYazVrU1lZY29iSTFG?=
 =?utf-8?B?azZ6aHJzNkFHc1hvUkRJd1A1ZWRIUlNPeDlzR1RhNUdtaTBBeXpzcFNMY3dv?=
 =?utf-8?B?cVR6NnFDQmNUaHNNeFVEVXFteHNhRXRsM3FWc2llSjd2OVZUOEFzWmRzSHdR?=
 =?utf-8?B?a29jR1pUTFB4cVUxdnJ5ZVBpOTh0bldwSHZrQlBNWkpoVW43ei9WTHBCaHoy?=
 =?utf-8?B?TVZ4ZlpzbE9qZHBMQkM3OEUzbkRNV3JVbm1MK0VsVWZobndyNnVSWVdneGNk?=
 =?utf-8?B?S09say9iUk5pdHd1Z3k4a2xyZ1g1SC9DKzN3N3NVTUlnN3VtVUZwbWJQOUZ2?=
 =?utf-8?B?amQ3dk1xZ3ROM3hlN0tVOTJaL0VCREJkMk9jOXIvUWRUOWFhSVFWVDF0WUlW?=
 =?utf-8?B?em5ZL1ZLcFVYZE9pVUxRWmJzQ2Nhc21ZVkIvV29MYnlTcm5yazFOZDlaWk5C?=
 =?utf-8?B?MFp1RUc4aUltREVOUE1WOE5VRjdiZmxSWFdrWm1IYllQbzczZytiVVFHQ2lH?=
 =?utf-8?B?R09pK2E2VDRibk5ha3h5TG8zQmNHdjR4ZHBXby8xaFpLNGtRTCtJVHN3bVQ3?=
 =?utf-8?B?bEtWVXJ3YTN0cnNUUXdGQTBoNE43SVI5TkhhSGNJU1UwSy9KcDhnR2lrVHI0?=
 =?utf-8?B?ZWJYaUkwalRCaWlENlVjY092NWlWWHBnSXhrVVdWeXh6d3NacTY5MXN4SHA4?=
 =?utf-8?B?WStaVXQrK1RqOUxZbFNoZEtsREtDanh2STR1RWZXTjl3UjZXUjU2NlBkSzgx?=
 =?utf-8?B?ZUVmclphTmlJSzM4ZlBZbXNzUDFrSHBDYkdjanR4VFp4MVhSNmI1WlUxa2kr?=
 =?utf-8?B?OHp2MWdZRUVzUTBYZXZuUzdqbld2ajNPejNHanhtRjg4czRBM0JBYWpYOW5y?=
 =?utf-8?B?bllKYkRDVnV0akFvbC9WVTdRZW1wZWVTOGk4RXdQUnRnVkhqUXlaNXNvUHNH?=
 =?utf-8?B?UC9lUmw5OTBNTnFYMzJQTmNUbHZWMlZHQTBPNVFSSzBiNVBYdjQ3UjhQQW5V?=
 =?utf-8?B?eGRtM2xybUlVNDk5eEtYajhZWWlnMElwWlM5N2FHT2FYaWZqVHFDbDd4am9L?=
 =?utf-8?B?LzQ1cTIvZzREZWhmWkplbnRHRDNPNDFzdklFTkZIUGpRR0pacHlBS0hDN2Uy?=
 =?utf-8?B?VDd6cDRrREhrODlwTzRZZ3o0VnlsQm14VHd4VlZNam9MRllhVWpEY05KWGdz?=
 =?utf-8?B?anF3UkpUU2NVb0N6M2M2TDZRNEp2ZVIwMVYzMXhHWFFXaGlGaHljQlFyWEt2?=
 =?utf-8?B?MFBIT2dxSXMwRkVRVlNZSHBUNDVBd1BtOW5qMitZQW1uYWlHb1FJNXoxNGFw?=
 =?utf-8?B?NzdrdmdGUG1Vbytmdnc3T2szK3JuZDFHakx1UjBhcWVNbHpTNU1zMU9nK1ZE?=
 =?utf-8?B?VllmMnBCbytjSXVsU05BQm1IVnNwUi9SaDhUZXdTci9wYXd4ejVhRzRjSkh2?=
 =?utf-8?B?U0wzQXFreUl1cGpmZ3Z1elVTTzZReEV6c2JRc1EvWi9KdTUyaFRIYi9XcFFL?=
 =?utf-8?B?NWY3NDN0Q0VUUmlKNjFwOGR1dFAwRFc5VE5pV2tuVTRXUnYvdkpYcjVWWDBS?=
 =?utf-8?B?VWd5TXpQeXFQVjJDeVlFbXQvYnBjVVp1Y3ZMaG5lM1BXZ2cvZmRNbjBOWldZ?=
 =?utf-8?B?MU9yWWViTGNhdzIrdGc5QVJuOGhGdCs0ajFjbGtrTHVEMzRxMWFNRmwzbmV3?=
 =?utf-8?B?Nm5pUWhTSGIvVksxczVGM0RncTU0c1ZSZWZhaVgzTWdvbDVvMW50YkxhZmhE?=
 =?utf-8?B?S29Uc1RVUHVWL0FEQnhHS2VPNU9DZFpNazBNckJaS3hLSE4vMkRmME5aM0c3?=
 =?utf-8?B?dDBRYUlNWXB4dWRKUmxGZ1NzR0hpOS8yM0pRU3BOeFZaeG1FUmFzMDdwa25B?=
 =?utf-8?B?bHNtOGU2WUE4OUNRbHVFSDV6RnFXQ2hTbldCeU02bW9TOXVIdVNlUXpPazB4?=
 =?utf-8?B?MXJNd3RtZmlzbGZjajNDRTdpMFBMZjBNMXkrNzZ4SnlqbGpiNkhqYUIvNUxL?=
 =?utf-8?B?UmtCM29Pam9jZFNsNzFQNDlYN2V1ZmVPOHBBa0NJb1E5dUo2clozUTMvNm5S?=
 =?utf-8?B?WUg0UEwvSEw5VnA2cjdseHd4U2wzL0ZudkRabFptVDdabDI0Y3YwNU5LNGNI?=
 =?utf-8?B?QTlDNUlRMDRlZ1hLWDFpeEhlYkdMcG1TM1QvN05vYkVacXpJSlpqUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46111ae1-b065-4d34-6cc0-08de4cac6da9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:39.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM6NmASYSzCE2QS6zwpWI5pizV2vsf3GHynabua7vkbgUqrPGhnqGhRSroZ5D2LztiUghyKQp85i9sDIC4bJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b678eefe0f312ebc59f654677c744f..e005b7bdaee156a3f4573b4734f50e3e47553dd2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -532,10 +532,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config, void *context)
 {
 	struct dw_edma_transfer xfer;
 
@@ -546,6 +547,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -815,7 +819,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.34.1


