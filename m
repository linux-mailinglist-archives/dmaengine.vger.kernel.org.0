Return-Path: <dmaengine+bounces-8043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 889CACF5E8E
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590C73037CF6
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8316312837;
	Mon,  5 Jan 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I/OVZgTR"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5F31281C;
	Mon,  5 Jan 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653301; cv=fail; b=U2i6aBmOoPtVMc2avs2Vj64PedmAv2ctmzTXKKIZFkMUnjKk6hAiBmAIBFBqr+WBuNQoM4MG7qSSGReRxg0tgGkFDwOuyRiCV53wuK2dWbl864kW6EOJI1cZKA/Akp/LwtnOaXLgNjFEcBRrvgWjhLMWmGRjQgpIH3tnFhtCZJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653301; c=relaxed/simple;
	bh=W22vmKstXYkmIGhE5qiPeFJ0wc/jLIRMR6F2v6Pa+AA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VH9FNbXB7I2Lin3k/GTvuTpkmLc/lnBJDWCxEjafxwVlDvvOURNSipraMRmSuq2Y+qs6jlz9tbpViE7+Gs+aic07F0TEiIv7TQzC/SXO4GsO4xs5VtpOq34Qytn/H7s4leX55dCTMESz6yxDkJRHdjaSfBr4L3sbfdMxcgxDsI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I/OVZgTR; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jazu1BFCU6Uo+DHL0apQGwSxvwdzM+ENshe0U3TjGpUkl2qvucVUvokl+L9eJgeEJ3BtoRrTU7O+oeRwlsjfGKomuGgr+aji+njTgRVmY4kToLAZPYJVcAbgo85nia/QpBn/BH6PFjbeiiIG2kUdv5ex2sgBuR63fyZASU7J2k5EJXipbGWjgxwJuBR/kZ6c2m3ifNA+4iJVVtC0aEMN9lNXBqiqNLB9VNygfQZ2a33YuXpMXn0+DjTlB5N6eR/mFJDTUqKcNMSC25Ea1FL48gF1l4AFHkE3O7JCoxBHNwM4Mw1GhoqkjrecyrXeV5kJw6uJAkzhRpY8DylXMrnLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC/ywaSProtu82uFSFteem/sxrv8h4ktguruv15MNyM=;
 b=Cbr/6NagccFRCB+5ot2K+Xt/g+t+LdbkZBOT38nI9jQvgyTjOjMZb0aJuGifA19xymqWu7/CDmimmKr6Mdp5I/AUn/Aunke5AFvK5gAT/opCPX0fWYFIEd3BXRpgjTv+P3oNT82Lhzl78dKm74vPA7CJC4Fjwz727FtvKqaoXWAupZ+9buxkATm1RMYlMdLzthLVkBq4qKISNqWrQGqT0KIZ4mAGQta/qqVvNGise9DkqKSbezwJCg8Mi30J9DSgOyKr3Vr3zUphjOZ+XYmwhHIOcowjm+EuQKQkRma8klHBC9O4mOy8fSpycFrcdCeDPEmifs90vitQQrq6OlcJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC/ywaSProtu82uFSFteem/sxrv8h4ktguruv15MNyM=;
 b=I/OVZgTRD9byPPGKBBM2eLvzMX4i2za47TrNetONSeAgusm9AHX5iiT6eS856uydN4+q8Ths3TjlN1Na5OXfAC5eZzppJdSgxni8RlR93kZ9JWmsoPV6hubepC/aR4pKYmxTuT2VgfeZYDIeS1K83yBI2cSFuR01zSlN9Bbtl4OUqCWvQ/YstAmGy8k3dKUu9wxPEWbGTEYWa+npVbXnmwCCn9gfDjIUuLzNypNEdhS+45vwuVbT25UNkKjAViCZvCc5XZATWaEcs5HVJzuBtppMGM3jp/lY5xK0nOTifHx/dG1/lHMXE4WdMMStMNuE2+43XqDWNlyn+olMkwpspA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:48:08 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:48:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:59 -0500
Subject: [PATCH v3 9/9] crypto: atmel: Use dmaengine_prep_config_single()
 API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-9-a8480362fd42@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=1301;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=W22vmKstXYkmIGhE5qiPeFJ0wc/jLIRMR6F2v6Pa+AA=;
 b=/I/d6fpB01MN67Py+YACfmjmrTztW973jnCLAwaw/w5KRbznbaxVnORbO8oXKZtDE6W3R/Ek0
 Ep9FgXaRCTkDnTN8Cn2wbOvelR6vDqIP3FisTE+/JdIGLrwZSZzNpY/
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
X-MS-Office365-Filtering-Correlation-Id: c880b358-f8f9-4fae-aca1-08de4cac7ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnU0cnJmb3loUFBnejBROUZsaTRTUVBsaWl0M3hBZHEybkMrUUZrOHhjVlZH?=
 =?utf-8?B?V1JhMkpqMWo0bTF1czJnQ1dIWm5McUhXb2RZSVMraTlBWXN4UnJmU28zVy9W?=
 =?utf-8?B?V0VBMXpSSWZ5akttZUIxdktocStjTlhyRm9NazZwS0VaelN0akpKdUtmZlBF?=
 =?utf-8?B?REtxV296U3c3dHlCa09NRTFGUlNTamFZUlNBUFdMSldZMStwaDB5ak54M25J?=
 =?utf-8?B?OGdkMXVWbUk0YzZMS01vS2J0MXVidVgrQk9aRnBnUUdrbGEwS3dpQnVTcjlj?=
 =?utf-8?B?UW1QQWNaU2JvUjhXMEd1Y0hCa2UzL3Q4emQzRzBVaUlLeHYxZnR5VDV0eXI4?=
 =?utf-8?B?QnJsV2FsTUMzT1EvL3ZINTNXYkZ2T091bFBZUTFiL3A3SXdNVW8yOXNrQkdU?=
 =?utf-8?B?dHFnZDF5YUYxMVVLSzEwRG1pdTNBT3NUeHFxNlNiZ0lOdXBlamUxeU1jbW9P?=
 =?utf-8?B?Ylc4QjZrWkNpVmt4U2tIMjJhWWJWdFhvV1pPa0JJdSt1OS9RS0NpK1c4czNt?=
 =?utf-8?B?NmcxRDN0V25FSzhUbGNoazlXQ0JNN0pablZ5WEVQZTRja1ZRK1lMdHRDQjZ6?=
 =?utf-8?B?Nm1rMS84Y3dNditzVkM1ZEw2a2JUS3BlS2FDN20wcHdqbEdKNm42NzByNzQr?=
 =?utf-8?B?cWdObHp2VzZXeUJLTjgvUkRDR0ZNOHJrRGE1MFBRcCs0T2xXdU5URWoySkdv?=
 =?utf-8?B?K3ZwM3AydmVCRldYaTNTZWpid0dFa1BMVHNUaU5DM3VDUkNyU3pkei9WWWRp?=
 =?utf-8?B?alFCQ0Rma1I3RjBqYm9UYUdlV20xcG5IU3g1VWhkMVNvSDNlazJRUCtOamdL?=
 =?utf-8?B?cS93bEtqY0ZwZDNNNVcvUVJMVWl6TFNydUxVMFRkaTZnT2oreXlDUlBwNlhO?=
 =?utf-8?B?RDlNVHVQdkhpMjhzbFZMY1g4aUJCbVhxZEVUckNSL202ayt0TFJwSklZVHJZ?=
 =?utf-8?B?NnJwRFZIeTBHVm83a3hvKzJycXVWOURwbi9hWVF1VFBqQW1EdXEwVE1RRlps?=
 =?utf-8?B?cVF2VmdndkJVQ0l4TWpXMUZZdnJnZTlyaXlyTzc2VGlUcVpxYXRpamkvYndM?=
 =?utf-8?B?dkZZcE4vN3kxZkdvNlZtUC93U3JLc0QyUWo3QVZrOFk2aTU4THJFZnhSc2lN?=
 =?utf-8?B?NHRRTkpsMFk3YzJWWG92VDhOeFQvOE42S25IQzVjVlpGRW8zR2VlNmw5dVJk?=
 =?utf-8?B?bTA2bDROWGdQaWl5T01ONVE1cWFDQ0d6V2hESUlSdmN1WFhaK0c1NzQ1ajYx?=
 =?utf-8?B?bFFqb1diRVlMb0NJUVpSWEtMdkRMRkQvQThzSWN4V1VuMEVoOG9aQWpGS0VO?=
 =?utf-8?B?VXZyMXdycFg3ckdFTkN3dVVDbEdpaEwzcjFuWEluSkdVQTNKUG8xYmJGcURw?=
 =?utf-8?B?cHNLMFJVV2FTUExKN3RndDJUeitsYXl4S0pKcDA4bnM2UGJwc0h3cWU0VHRF?=
 =?utf-8?B?a0NONDdScEpnVENuc2gzTk9Qa3A2S0xmN2ZZUHNETXZHN29LMktYRHVxUDIw?=
 =?utf-8?B?TzBDQmg3TTM2eCs1bkFJRHVMdG10NVlTSzVSd2xaLzh0cVdxUEdlYlpyamlF?=
 =?utf-8?B?aWZKYzVaRHU2NkJ0cEUwc1B1L3BSRVN3K0QzSUZzQ0E0dUhSZFozT2t1TVZ4?=
 =?utf-8?B?TEJRamRHaTUxMVFPV21zVmpUSlY4aFg1cWNCckFtVmVFekVlSGh1aWJ2TmxS?=
 =?utf-8?B?dVBzOFRMeDRzNjZuS3p1N2d4VVE1S29qOVUxS2Z5eUllR0t1NzFITWdJTm9I?=
 =?utf-8?B?N2YvZS9LUmt6VE90NEVKcUtURTNxWkhXSmpzRFNRcmRMaXc2bXBOeDEwOUd5?=
 =?utf-8?B?ZXdZRm5uUEV4aFhVRytzN3ZnMWkrWTcxNWpXV0xsSmprU05lMTZoQ1ZtVldw?=
 =?utf-8?B?ZHdhUmFLWjZGb1EwTnhCMmtuSmRsT0FQdmQ0TUhLbU1UL1lBRm9hSndlSFRa?=
 =?utf-8?B?eVd3cnVxYklxbUJEbnZPcm95aDJGd0g5ZkQvVk5pbVZGTGx3VlQ2TVRpSk1q?=
 =?utf-8?B?OTJLQWZhRjc0L1NSZFFhcFVldllhWlhmUmltTENlMlJCWWM2MUY2SkdUakQr?=
 =?utf-8?B?dkpuK1BObnFsMWdJWTdJMUpKVkZQcTY4eWEwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21jd0kycFFIT2ZVdHZUalM2U1lEN25OK0JiS0luTHpZNlFpdUU4RFluQUxS?=
 =?utf-8?B?MU95c3EwQVhqOW9xSVJmSlR6STR2WDRGS09tTjVrNnFzckZwWThySk90ZUFm?=
 =?utf-8?B?cTBBbGtTWVljQjB2a0F4MURmeCtkRm1DbkdiSktOMklZUHVYV045b1BJTVlF?=
 =?utf-8?B?VlJSMW9tdnM5WU1wamtrNjhPaEd6MlNLaDN5MjU2Z0dPNmNSQlNaL1ZRVFda?=
 =?utf-8?B?dElqSDF4RzErV0piZC9YVDNCOWQ4WGlaU1AvYWhuLzVrVG5NR1dVZVg0L1Rr?=
 =?utf-8?B?VWpTMlRHQ0ZERHBpdjdXYU9uYUJoT2d4SXZ4MTdmbTZqaG1YVzFRM1RzaFdI?=
 =?utf-8?B?ZWcyUU1oVFR6MHRxRWJWZFpnYkthR3NMYkNkMUJWTVM5aVllZXluVlVXTndH?=
 =?utf-8?B?QW9GMGFSME5idVI0a1VhQ3g1OVk3RG53UEVPTzUvMGt0Yjhkb20rVXg0c1Nv?=
 =?utf-8?B?bjR6aVhlZmVIZEpBTTJYTjZ3aVBlYy9Yc25yWTBQeTNqN3k1OUZ4YktXR0Rw?=
 =?utf-8?B?ZG53TDVHSTJ4c29rdzFJd3h4YjIvUjdnWDBRbDNpOVRYMWw5dWgrWXpmSnpJ?=
 =?utf-8?B?VFRSQ3Y2ZC8yOHF3amE3Zjg3dk9wRHZCajh2a3paM2RJNzZxVTBQeHBhV3Jj?=
 =?utf-8?B?a3FESjNWUFkxWEJBbitpUnB5bUVLayt6Tngra3hMdGMvc3RxdXMwQTNIR0ZF?=
 =?utf-8?B?ZVNJbWcveThRTjhmRDhLWnZJZk9kakxlVkRIalZXYjA0d0s3SUlsZlZOMERE?=
 =?utf-8?B?VHV6bDZoMGdKbHVaS2dyN3F4TWU3aG40b3Q0SVpkbnNaemhxWVhwSmpteXpV?=
 =?utf-8?B?bzNKVzA5YjI3OE9Sek5rZVlEVngvY0FkcW92OGw0Z2p4L25nZ3lMTU5lZ2No?=
 =?utf-8?B?bG9tcXFVWWNNN1F4eDR0OTBUWjNjUXZwb1FIMlQyUnlZcjdrTjZubGJkYndH?=
 =?utf-8?B?eldDb1lsY0VPVFhiclNEVmc1OWF5UUtaUEFhcmh2SEdlS2xmbFBDU3JIMFBy?=
 =?utf-8?B?TElVcXIrejU5Z2k0Qkhxa0pFVFZKaFJjSEUwTmtpdkk5RTJHZktlRG9RVEty?=
 =?utf-8?B?MVhLT3N3cjliVUYzL0NEb3FDQldQVHJablBSWDJyWkRQNENiTWRLR0Q5Wmgw?=
 =?utf-8?B?RnhtVnVlYTVyRGdQdEpVOW4reWhHcDdhNVRTc1A4TmgrUVBoa1pVUFg1WGNW?=
 =?utf-8?B?cFVyeVhkeXU2bHl6bjFOYjRUYUhHMDI1MDRLOXIybU4rZDEyaEZVK1RuRWxN?=
 =?utf-8?B?U0x5c0pOUHdUZFVzMTY5NlJjTmFTUC82cmswdjBNMTBqdEtDWWFTdm5UNnFq?=
 =?utf-8?B?MHlZT1k3Q1hUZ21qZDhHZExVbEN6Y1ZuMjZUY1Z6WTVLL1lMU0UzTkJaMk5y?=
 =?utf-8?B?V0dJaHd3d2FMdnVuSnhMSG1wZGhTMitsZG12MG9NSFIzYWphT3hxN252cDll?=
 =?utf-8?B?V1pka0hJeGVwUjI5MGpISW82TmNMZ3lLZTFKTUJidERXVEhQa1dlY1BFbzEr?=
 =?utf-8?B?aFg1bjV4c1pxdzhTZzdYRUJpaHg5QVNndXE0SlNEMkRPSXhiZ21lVXI2ejJD?=
 =?utf-8?B?TmE1VzhvQXhLZXpQUEZjSHFHZ3ZSNUZaT3laS0s5RFAveWJva243K2w2NDVH?=
 =?utf-8?B?UUUwT2lJczhYdUVGZ2Q5NitlaWVjdWJxRmRHVHY5Sk1XSnhPeVZkQUZBTCtv?=
 =?utf-8?B?MTk0VnNqVTgxQ3FnSTF5d1BPMWxRSjJjRHFCRnhrVE41YmRwVEx2Wno2TGly?=
 =?utf-8?B?SGZXUTl6SkpkRFl5V1JRWFJyNmlSMUthc2s3bzl6c3FLVDBITjYzTkFsaDRK?=
 =?utf-8?B?dG45SFpTVDFhbm1ha1hxVFUxbTNVNkdtQlFwaVlpU1ZQTzVYZnRXcXZocUtn?=
 =?utf-8?B?bHpwZmtmZ3NkZ2lFQzFXbUZIVkNSZjJpNjJsWGkyLzNRTm5VVHdBWEhLQ3lr?=
 =?utf-8?B?WVRiMUdRL2FadGZaYXFjeTdEd25tRmxoWXRZZGx5cnh4OCtLc0NxOW1oYURo?=
 =?utf-8?B?N0I3QUJPdFZzUVdHcFAwWVB1VnlNYW1uaEFJY0ZQUWFZYnZrWW8zQ0I2TDhX?=
 =?utf-8?B?WUlkeExGallnVHUxWTlzcXMraXhYaU1HQ1YxNkZkSmZzams2YkJPdkpDMW4y?=
 =?utf-8?B?R0ZjRVFpZFFUcXFZTDNNVCtMeFdzT1N1aWRnekNlVC9FUFU5YjNLZTU3WjRD?=
 =?utf-8?B?NE90SS9CT2QzbzJsdHYxNTZ1Z2lnd3FTZG82WTBLTmFvN0w0UmN4QThOQUZI?=
 =?utf-8?B?a252VlBVMmpVSEdURjFCcFg1UUdqOEF1MzdOUjNsTjBtMmpJK0tmRUJ4K3lo?=
 =?utf-8?B?WDJKV1dMTkFXb0lZTmtEQkFMNkZYUEpDZi9WRDBTaHFmK1BIYU0yQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c880b358-f8f9-4fae-aca1-08de4cac7ef5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:48:08.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQXYbZXof/+UDcPXb0THIQwfFyfeOqT2JMKO64IZaW7WiWr0qO7gMfzClOyu1ozmH9qmujJiDkG7N8+Pt0MVWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Using new API dmaengine_prep_config_single() to simple code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 3a2684208dda9ee45d71b4bc2958be293a4fb6fe..e300672ffd7185b0f5bf356c2376681537047def 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 	struct dma_slave_config config;
 	dma_async_tx_callback callback;
 	struct atmel_aes_dma *dma;
-	int err;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = addr_width;
@@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					&config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.34.1


