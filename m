Return-Path: <dmaengine+bounces-7807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94358CCCAD1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8AA530442B6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46634EEFA;
	Thu, 18 Dec 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lZ2cTqBB"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3F34DCCD;
	Thu, 18 Dec 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073421; cv=fail; b=rAf6quD+tlvMduXSvkHmotCDzpLVFJqT1DZ/KlsAsTgjPWLmXcWFjqzV5Od1i6eXeoV61OfrgNSIXeLNIYLQztUxW+SFAFuvWztFjPOQbbyZcGjGHZZwCVdBy8YR7Ql9++0xr+829jG96N7GRpb/7wxFLF6lL600tB478zQ0TS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073421; c=relaxed/simple;
	bh=VHS8TmOMGP82ktXP5+p/w9JyqRqfYYWwvmZgaLDJnYQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EITY7x8m29GyZNg7dYiD0DGxJafMY7Yd3c3Lalr5kLTLfHVwNrbxbjhe+axDu7yZX8YoKGpJIY07cRF7pCecwp8AKIjsUz12KOY9N2Oe43HYqrKaAQyMGxXXcOnP6hwsgmZjdPW868zT6bft7ntUKeVWtDkZxlYVrGqw6Ohqs1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lZ2cTqBB; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imMi6Bp/lo1arSLGHs+gf0ueOXyEqCagiVBYy9Gy0n1ZYt9/CvjO+HRNxDmnIgP5crd9ikICI1Q6B/JQqRl1ulGaAyap/ZrBdy/BN1dJe0Qq/g9Eswpq73qSSvcJ0eaNtEKhtjvwLetaZDtI2qeaNAie3QFrUBWP4ZsHfm2BiPFynBEXC+Hlhgx3ZBgzDoOmw2x9IU2HaXPCS6u1+45ltB5XyagQLpDQ0/HmGur0FhXHQ+ajbgzYJKnI2AuJJKKwoVm4E5hJ/N3aGj+49vAwhMdnssX4mZWdu9wFAKDIQa+loyY4r0hj7RPpmsiKt7aQVid6a0UX6iGtmSrZSX/YUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9uEDHDbfM5rwzcYum9JXHwXqo62a6HbPA/JryHN9dY=;
 b=ZXs+9d4j6FhYOPjN753tGCbidLpIr+Sh5Wf/McWoqGDAWpI9+4MuWMT0qDxBa+U8CDDQEDFpyAkGiXKqjGe1kkjJCHVa67nRTA/fpq1T2oSl03sRmJtcbN9UKevIB96dUdKC9x+A0+X3qPClT0zyZoNfmqBuM1B8kwlJ3hyWsg6QxSsoCxzOIaKGrlkMfN//yr+w0mq+gCtS8eANgIc3geKCeJ4gxPYXSz1SNsDVYAxLy/aHLAUvnxlDcSB5ID9qexW94mRrGCgeK6RURPf3h+N16T5wCDfLXJd0ZaZ39KwziELvIWv31S3nKgfAfhlqHeRIg5w/G707cn16Dkw/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9uEDHDbfM5rwzcYum9JXHwXqo62a6HbPA/JryHN9dY=;
 b=lZ2cTqBBh/Ulv6VPAVILt8CwNvINZZgpRJeFGg0I9NpdZ3LTlO2tHAlzgMeDEvJIZ9vgHtMLssZUZg/D3CFnmzxJyCwADVOqRqI2ZJdQLrl5GwrKKVYSoe71aCmWZ7JcivHfCY7HZJOvY5lPBRgBi2BdTHqig18Rp3ABcRW6DT3RKaFRTXuG3QEdS+jgtxc+ay+FiKQgoeXh+Jh50huPK9mUQBYc4Hf2Z1meijfdMsWDA9NZ6UIf/y2n9G0qQfqUAeKZBURAfeQu3BY5+8NBXbR+Ajo+4ZQkc6HG8A1gbQUJWR4/Q4qs/vCNBkRJtvKJMD85LSfikdHjQJefcR/HMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:56:56 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:56:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:24 -0500
Subject: [PATCH v2 4/8] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-4-c07079836128@nxp.com>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
In-Reply-To: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=2903;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VHS8TmOMGP82ktXP5+p/w9JyqRqfYYWwvmZgaLDJnYQ=;
 b=cCO3DaR2FUEcq5aIxNiq62hjl2RcXjanm1DUYS8Yy+74ZT2xEdrOnKQ9+n2QCNSoFqQ4Zj1aL
 TJqkH5GXsPsBG5IF+sYO0v8bA8OmvLxEooH1M2Z4aLYwCwHzszWvc+X
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6c6fe0-7910-46d8-a03f-08de3e4e11c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TSt1ajMyWXdsSFlaZ3Y0MEo1YzR3Y0kvYlRYVVRDa1BsQlJPY0tTczV4R0Rn?=
 =?utf-8?B?b2ZkNVJRNk1GL2d4SE9wTjF3dGRzMFhnYTcwS29Jc3pCNFl3TE92SHFKTDEy?=
 =?utf-8?B?bEJocVowclMzR1hnVCtzUmVGZ1cxeDdvTFdudjN5Y1p1TW1pVytTamZmM2J0?=
 =?utf-8?B?cStnWFJJc3A4K3BZMktWVnlvNDVsZ2FqUVpPUFNOemtEWGNZbXRhSkNEODZs?=
 =?utf-8?B?RG40b1dDaFV2b3VpL3ZIVHY5bUdaek9wb1VOYVAyY2pOT1N1dWU4bUVuRFJH?=
 =?utf-8?B?cTQ5aW50Q1dEbHZLdWFOL3FkbFlDUTVrU05HU1JldHdYVXo2Z2tKR0lxZ1p4?=
 =?utf-8?B?elU5YmcxTkk0aFRFVExRM25IeFQvRitLV0dYcEhDMlc1cGp0aXJvNG50aXYy?=
 =?utf-8?B?dkhsa3l2V04vUGYxcGRuMERGdlJuRXBkdWdxRWs1WHZSZTRna2dDcytCUExH?=
 =?utf-8?B?TlNqV2RDNTVhWDh1UURaOXJDazloTmZPWTV3OGhXb1BrMVVGaks1YnJ6QnE4?=
 =?utf-8?B?VTEzdVYzUEZmSlNKZHFacXFyYlpMVzNqdnZGaWwwS0NkVUZDYmszWUZLR1B5?=
 =?utf-8?B?NzJSMkxOekFWR2JNV0ZyeUxIRTl4em9TVEszVFluNUxiQW1qZnFvOGVYamND?=
 =?utf-8?B?VUozY2ZMOXlUaVZEZGJuelF0VE5ya3NiSlNGdGRZbkNicHFyZ0dNZlQwK0VL?=
 =?utf-8?B?a0sxdWFzMDBIRDNzUDVUYksvWG81T3VETGg5eUxQdHRVZHdyaGJrc2wveXJ0?=
 =?utf-8?B?amhMSll5ZGYzTGZXRFordEhqUWh3OGRORDhJbWxCZ2hUL3YwQXVUbm50ME9Z?=
 =?utf-8?B?YWg0RnpWcjR0dG4vVDVNejhCYW5tMUpCaDJ2YldUZ1ErbzdKQ3A4MDczNnNI?=
 =?utf-8?B?bHRndStBVG5LS2grQ2JRL0RoMEQ2azJDTEExZ09DdllOU0EwVFA1VnNEajdi?=
 =?utf-8?B?WEVJeDlJWEZhRE1qRzBDZFVBN2t1b1JtY2NTMzV2emRjTVg4T0gzRERKRWdC?=
 =?utf-8?B?YkRVR1UzMEUzT1dUeHlJb0tLNXVlNVRYRVlwODZFd01TODNLcmtneXliaFgy?=
 =?utf-8?B?a3VsR1Y4NEF0bERsUm03U2R2a2xYSUJXRURhdU05eStsM0cvTnpmYmcrOTd6?=
 =?utf-8?B?NnVwaWlCckFpOVRYalh0SERTb1pYNXR0VTlUK1dyR1prb2dlN21XU2Urc0k3?=
 =?utf-8?B?aVdYZ0JUWkF6WW0rSzJIYzlnNzN3QnNpS1pQb1MxSExvUXhtR3NWWFlHd0I1?=
 =?utf-8?B?SkpFbUxDY0JCTXlwVjJjaVZZNUcydThwSE1icmlUS0lCdHNHR0pKOC9KSUsz?=
 =?utf-8?B?dTZUT21CRmc0UEpGTjJKL3N3STJTSmNtZGNDdElBMHI5cFRLN3Q5N3ZZZG9K?=
 =?utf-8?B?OStvNjA5R1FGZmNKUmhZbStsMkRTWWFMR29Sa3Z1ZmtuNTJrSGtac2JWc2s0?=
 =?utf-8?B?ci9Sd1NCRG9RdU8vY2hCRld2aEFhbXc0bjdGUFQyQWFyWEgrcDZob1NkM3VC?=
 =?utf-8?B?SDFTdHEybzR3TzB3ejJSOE1Qak53NzBpek1oczBPVG1mRzdOV3o0ZVlKdmlz?=
 =?utf-8?B?Wnc5N2R4aXMrMndhbUdac2o4ME1LaXRHallWQ2k3TmxRdEk2UXZlZmE1Rml3?=
 =?utf-8?B?S3FGMlZWTWU5ZzcvK1puWGRpaDE5SHczSlZCdFMzNEp6bWhybnFPbmgyUnJl?=
 =?utf-8?B?SFFnZ3R5cG0rZjdxRkhCSmVlYmkwY0huWVlDT3JLQXo5a0dGclNTUVBiYXFR?=
 =?utf-8?B?OCtMdHBkclp3dTQ5U1o4SGhUZU95QXdEYStCVDFhRjlmVlpNMlNheSt1dE5n?=
 =?utf-8?B?SEpTUnhOV0NMRnN0VnFuUVdnRzFhbnlycFhFWE5Oa3ZtbktNblZUNHhNVVdL?=
 =?utf-8?B?dHdIRTM4THpYdS9XVFhvTmMxTnNpdEZDREpublVzUTVpbEFCS3MxOUQ2ekp6?=
 =?utf-8?B?ellTdk9XYys4K0NSdmxoRTB6dGducGhNb0FrNnJRSWROamRMZVRPdmZMaVNu?=
 =?utf-8?B?RHFWZU4ySzZsTzU4UVlBeDc0MXpRSjZJeFZibURFRC9nTDdiMnBRL21XSkpt?=
 =?utf-8?B?anVZUEE2NUR5Q1RKdDRhQml0ZmxPMi9haS9pZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smp0Y1dHQ2syRnhxVXRKalNMUHU0alk4b05TU0xtNXhDcnFkaHYzQ3B5R0hY?=
 =?utf-8?B?TGRpTXNLV3ZPMXlKeXpmbStZdWFjc3pUaE02NjZaV0FkSlIwTDZRcll4dDI0?=
 =?utf-8?B?Z2hSRCtCL2xGTXkyekdQc2hWZWhuL3NYSmEvNWtZVXpzSnZPR3VxQ1VxWlpB?=
 =?utf-8?B?ZzZObnNmcXVnTVViRHRpSnZkV0NXNkdyVTNtZlc4Uk9Oc25jcmJ1TEs4SGZS?=
 =?utf-8?B?TWVMQzNEeitqVlFZL01Ja1VkMStLUkRqMmxZODFRKzl3NHo4czh4d2hLRFpU?=
 =?utf-8?B?YnhZMDJJSlFkamZraTJ6eWw4d0ptcjlrRG4vUXNldUl4RGczV01rNloxRnR2?=
 =?utf-8?B?S2Q1TE1NZkRGNE1nNitpMHhRem51WUwreW96OE90aFJUYTN3YTBMZHJVY09u?=
 =?utf-8?B?blNkQzAxdFZxUVNBWW9XbzlxM3I1V0tSaERZV1Arc1BEdlczbHFIdU1kODBE?=
 =?utf-8?B?S1BTNjh5a1Y4RXFIQi9LeGNrUkNjL1g5Qnk4RzdvWC9URGxlRHBqTGlrVllN?=
 =?utf-8?B?T3BKZE1MQ3VNU2hIN2p1R3pRc1UwaTBHOVo3eDVJUS9iWi9uWFI0QUV1TnIy?=
 =?utf-8?B?U1VCQnVVaGxtUUFtZTMrOENmTHAvRFlVM1A3YVNOVEtMQ3RlRllGbzJVb3hP?=
 =?utf-8?B?QUwrQ3RVb2RHdTE3MHpkOGNMaFJwQkwrVm8rbjdJVmM3TjlYRDg0STJmWjVB?=
 =?utf-8?B?UVM4eDdPVDlXanlOTDVOTkpoSmtDRHp2QUl1aVhSTG9NdVdkZGRwMVltOVBZ?=
 =?utf-8?B?WU5hR2t0QitocGFRRCtxd1ZpY0JnNjFvMGxDS05xdEtSYWwyWU9tSnN0a1RX?=
 =?utf-8?B?UWZCT1RTeHZNZjB0UmVqcUxEa1BPc2pRdGRlYlowblMwMC95dmdIVTFydlpk?=
 =?utf-8?B?bk9mU0wvZ0d5TXhGOElLNTl0Z1k1ekpVSFdMQTl1ckRhc3lmM21vMzhUMTEx?=
 =?utf-8?B?VDBCNmpkNmNwZjZ0VFVHbmdCYnJQaVFPOHVhNnJFVkpvckk2R2g0VG1uTU9q?=
 =?utf-8?B?OHVNS0JjOERJeWsyYXRSWng0K3FtYTl2L3ZWOVlETExvMmpoOFlvQVJjRGJL?=
 =?utf-8?B?MUplS2FBYmpuS2tOenpuT3oxa291VExDUFUwSTdreXVzbWV5TWVRWDlsNzNJ?=
 =?utf-8?B?WXZOK25SMUJ5eXVzbi9nN2prSFNxVURxeTdLSkMyaDdTVDNveG5pbXdkNm5i?=
 =?utf-8?B?NVFxSE92aDFPc0k1TTlZR0ROQmUxbVdkUGs1eXRMSldJKzY0RU8rejJpNjY3?=
 =?utf-8?B?b0tQU1BMK29IcHdCNEZHVEZseFI5T1g5ZC9YdHNVeTVVMTNvampvWER4Sm1B?=
 =?utf-8?B?eFF3ZU1LQzNkZHhaeUZ6LzAwNlhDbU94WWJqWGZCZERpUmRBeGFGNzF6dnFE?=
 =?utf-8?B?bjNLU04rR21zNitxNW1Lc2xUaHNFOG96ak1TZDdIVmFIUFVpRU9VRzFzMDdk?=
 =?utf-8?B?THh3SkpnaGRCbktqWFlWQkFocXUzQzN5Vy9Ba2czR0xkT3Q0NWI3aTVWekRr?=
 =?utf-8?B?Y0lMVE9ZbGhTQ2pUTkhnR3lmU0psUVBKOE1NVEIxQ2pCSzJRMHpyREtEVEtp?=
 =?utf-8?B?bC9ySjVUMXJKSjhhRnQreFRGbkdaVmR6LzlzSUdsYWhaSGEzc1NqSjBqcTBs?=
 =?utf-8?B?S3NWZExEanhrcHViNG1PUERzWWNCVVhIOUhXYU9ZU0RjQXlkcCtYRHdsd0s1?=
 =?utf-8?B?ZEljOWFjL2JGRWluTG92R1NLVmhUQlhUczNXWm96ZjliMDcyUHpFZ2pESjMw?=
 =?utf-8?B?a1BlZDloUWxJeFN5K0FHZGY0YUlYTUkrVG1oU0Z0Ly9RQ3g0OVI5eVQwMDY0?=
 =?utf-8?B?YjhWWjVvd2xQNFhVdGlvWHZCMS9Za3N5enVHc2ZMZGN4a0NvR3dHaTU1N2lm?=
 =?utf-8?B?TnRUQ3E2cWVVcEEwQ2YzU09STmFSVHBnRFo3cEdWSS9TTXNrTFd6Y1JWTG5k?=
 =?utf-8?B?dWZyZmRScFovVnlLZUsrWGI0RWdsakREanRXeEpvNTFmaSs5Y0lZNkJMcmU4?=
 =?utf-8?B?SXVNS2pYM1pVZC9valYzVXFWd0pHdDdHQkZFZlc3eklZazVmUENRQmdUK0sx?=
 =?utf-8?B?RDRKcnFJbGNJa0xaMEZaNU8yRHAwTEs2RlJaL1Y5VHg2bzlGQkIyQ3Fyaksy?=
 =?utf-8?Q?1yHPbiAkIvQE974aoyZ1pmCeF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c6fe0-7910-46d8-a03f-08de3e4e11c0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:56:56.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RexCv8vIL8QXIVFYxnuke0bHgmqFoPWwBYhagSEsuqXx6DXtUxrmMVBZA2fLvvLUTxMb0OgmcHiusx+7jwfltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e005b7bdaee156a3f4573b4734f50e3e47553dd2..1863254bf61eb892cb0cf8934e53b40d32027dfa 100644
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
@@ -550,7 +560,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (config)
 		dw_edma_device_config(dchan, config);
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -569,7 +579,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -585,7 +595,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.34.1


