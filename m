Return-Path: <dmaengine+bounces-6854-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9DEBDBE40
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 02:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2745B3C3206
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC075151991;
	Wed, 15 Oct 2025 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="biDehQ5g"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51B136672;
	Wed, 15 Oct 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487232; cv=fail; b=LYiQFXjYT7RRKaJ1prs5ERYCiz/QvfvNBIqb+Rzej/20Pj3ihXr1A8YSXV1dPQVNmc2g9ETpL0Zc45OPFzZoWzS8RnkPGD+enbwh77AnQbknplsIB4Jkx8tQbTWZwz2Z71poWTMXo+NhTUoQWGSEdLIxrjog3YsxMXotiKm/ec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487232; c=relaxed/simple;
	bh=97tkk9OmQoXizOuxPgEphGBRQgUoCzuaeXoLlbLFaWw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V1xDTVkYj/eA+Adoc/HFOx7rKMahHtQRY0ppywnwnS0y9GcRU1NSAx28nGXM42Oy+A1VRdibY2/aEd7+HxsMTfQ2uEIvSPy9CVscm/MAeycUNRHOdWz3CvcTj9aeW2AvTnsj3RzdyfbGhqP6GVabIYlfDwecImXpFcrUtCDqeiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=biDehQ5g; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI2CmjU+fhPVQYxHBXDIHkbNj7wivOEHc4wmocsmbq3M8zJJBi9uJjHWLJYzP7cg3rAqLQqgU1vYH4ZjoLua1/ykk4KKM+0xOQNAxrItSIKnl3BhQljmZHwcyjWx/d3OQ2+M+gOpt356LR0xcNuCvc/qFueX6LIwY9Qd/DkVIi0ABan6CTVu0rq9BAACn5AJF82cwdd6zSaAMF5SZWKXxaWBy7eirlAaS55V84+XwJFTgBswdtXVG69fS4odRNCMoJ3X2z7cXF7/rCXfPcWt+vfX8JFq7OgYYNyuOsAL2BPKs3+bid8QPLqzOQzHiAG8TZ66lTyuHSQ/m6dcH0UOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvoazLV5J4TEZmK5+WQw+H6HKSf1cCX8FpgumH6O5PA=;
 b=YZP8rxlcjtzIrnO1DaiSAI/0pT/MrEAhV9VEjDaePxeBNFRWeETsBF/HSJxMIrit1b0ntgJRk3rWG/mmSlA4GD07Z0f0Dt8FHjLGUXxrLnwTcuDFp0YnmymspsjVVmDCK2C+hzPyipGYVjgWyNRmcmGHHW6h2eHRA/ozT/Pfyxc245JO+ioqTFnEQXBM8KWL/mz7SyvYTBupuQWuOzWxvn+tdr8Lr+w8vEiZ0w0IThIvzU5njk2mDkqSbSg15EGgRuN/vfan0QeTNNFMiOLHcZefV0QVWuDAvOXHlL86n5Fbu2sLLyGhfawWi0mugOEplQRmTAjvLvyeR3p0KNXeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvoazLV5J4TEZmK5+WQw+H6HKSf1cCX8FpgumH6O5PA=;
 b=biDehQ5gK2EW4zZnIEaOHNerkS2qnhwNNJhqpfpazdKqy6GPMO8ZysLs+okiuZokYYE5xwWZnwudzrRxoQY5BF0rm+O0R8gBdAID+DpoDaO6wdfYeG0za0y6k8o3jOqnLEvQyUpnJLoHx12SzcUO0uA3u3HBeHf2jtUPYXlcdBpfeY7L4d961cwbQsok5wKAC2imVd1aeMBO0Mf/qefmxJfE2vMSc46YVU1NskYiVhAWdaOVUKnRe5Z1DLMkzbLduEst/ASI/ugVlpGqvZAM0E0IIe9gm3mOWoeVCp/SkA87pmGu+xggUEXX/sDz8bkqm+C8Fti+fnEo04oT99LjOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 00:13:48 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 00:13:47 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH v3 0/3] Add iommu supports
Date: Wed, 15 Oct 2025 08:13:36 +0800
Message-Id: <cover.1760486497.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|BN9PR03MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf2da77-0e21-472f-2817-08de0b7fb5d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi9WVmswUmgvcStkV3JpMW5MeWtUeldtZDBrQTRONjdkb1ZIQjZsVllDS1pU?=
 =?utf-8?B?a29qVjBYSHR1TG42blNLS1l5bEtDcVlTbllSeUtDa1FIeVIxQm50OXUzTmh2?=
 =?utf-8?B?NXNlOStrK2hsd3E3S3BxaEYzWEIrMXVHK2xnZnJVMTZmelNwQll2SWNBU0VC?=
 =?utf-8?B?ZXFlK2RnbktPQW94WnJuUG9CUVVSZEZ6ZFd1VTgxZEMzM3FOQ3lCMFB3NzVD?=
 =?utf-8?B?aFlEWGNLbCs3SVBKRGFJTzNuakc4SkVzdjF4bEFwYVZtRlo2UEZiNDFhTTV1?=
 =?utf-8?B?WDNRTWJUWVRjRklCYk8wcGdPelVYSXpReDdDSWpZeVNmZDZ4MTlGSGdLR2JC?=
 =?utf-8?B?d1o4ZjljVjEzVVJMN0RGRkZZZW4vVU9WR044UmxWYmE2dnRRMjBncmZldG51?=
 =?utf-8?B?R1grSE5DN1lrSTBYMExYcURFeG5yRFMvRnh3RkhiL1BHUTBPR0xUbis2aU1l?=
 =?utf-8?B?SWZ4S2ZNejZmTWNGMFloOUdZY1V5c3haSFhrTFF2Sm85eWdsY2o5YzlJUWs0?=
 =?utf-8?B?VjlGRnlwUXNaNURzanc5bHBIWlVWSFFYNWdmdDBXY1lSbVlIVlNVZWRDN3kr?=
 =?utf-8?B?RFhpQkV1V1NpNXhnVDcvNHRLcjJqR1Zzend6b3lrN0hIYnFNNWhzVko5bU9W?=
 =?utf-8?B?WTlLYk5XSU41Tit3TkhEOTJSMEhaQUpUUEplVCswdndtUllzZlltZlJxQW1j?=
 =?utf-8?B?WktXd2JTK1RRelBRemYxSVRhbnIrRytFQXB5TVN1elNWY0FaOTJueGU1YkFI?=
 =?utf-8?B?a3NPcFFGL0hnano5MHNVWFZQZlFQd0NFTHFvdFlrckFWTHpnZGlEcVZBMUxP?=
 =?utf-8?B?aVBJaFdkeGs5aVcwNUFES2Njd2JRUVZlT2R4VVNBeGoxV2w5WEh2RE44dGJl?=
 =?utf-8?B?MlhBUy9MVmR3WFNZZ0g0MWFLNjVUM3I4VkMwSHZZRWZGNmJ2YWNKOXZ5d2hD?=
 =?utf-8?B?cHNLVkZGOXl3Q2hQcnVXNWNPWkZjcXBLOGJWeklEbUM5djZjaWplU256S0RM?=
 =?utf-8?B?bktid2prbmdVYXRuVTBVOVVHc3duSEcvb0lwemNPNmJEL3BsU3NSZ3ZDUVRs?=
 =?utf-8?B?Qkozb1ZhZGhmSURWdTIrVUZJa1lpTyttTDhmdnNWYVVUNDhlRm80ekgyT08x?=
 =?utf-8?B?bXh0MUREZG5oaE1zSzR0YjBXbnZQUitLM21GdlNHclg2QlF0QjRLYTdLMkxU?=
 =?utf-8?B?OUlZaUZhNitaSzFXUHVEY0JCdStRZFE0Zyt0NE4yYjhZQ21CQXgxc1dqcTBU?=
 =?utf-8?B?bFc5eE9Bc3E4TThhY3NFOTFvRlo3bmVqMzJqdG00WW5nZWtaQlZ4ek5ER0RX?=
 =?utf-8?B?a0NsNkxmTk1rdm1xK3p3alZzRDM2R1NJbVZuQU5TemVkNE9ZeURmd0ZpRSth?=
 =?utf-8?B?Z0FBSWlmUnpTRE03SXpOSnhUMHZ2QzVrS0hXOGNZQWIwQVFKVllnbHdJZ2hY?=
 =?utf-8?B?T0FxQUdJMm84TjhCTjBvOVVSQXlaVXlzZGdEWVI1NVU5UU02NXo2VzVkK0pC?=
 =?utf-8?B?ZVoxbk1jVjBOM0JRV2dTTDlyVEdMcmtuKzBTc0ROMHVDamh4YnM4TWY3Vytl?=
 =?utf-8?B?YjNtZU5jcU5GRFdPZDNZbTNFTkY5M0V1UENNMk5SdVp3ZXlXS0RuOWcxS3E1?=
 =?utf-8?B?MFFvdlFUY3hQeGJSTjlOQktYOHBub1p0ZDc4ZDY1a0l4NGVHVUJLTEdFS0Q1?=
 =?utf-8?B?by9IbmlmRmV0S0lGQWVZcmZIRERVNFdQMkgyaUg3WGdVMWZ3d2kxWFZ1MVlX?=
 =?utf-8?B?YTRDNVR6OHljbWtaZmpxS3ZhcGhWRmh2UFcwMGdmbDJCaXZ0ZktTQ3BkSGJX?=
 =?utf-8?B?K0hoeVM0cnVsejUzNUMwclpFTFI2Q01ZdTcrZGhoK00wdzA4RWlzbkx3WDVw?=
 =?utf-8?B?RFcwT0EvUEI2aHREQlB0Z1JqZzl0YzhhckhSbXljRzB1ZGV0ZElISzNTUnNV?=
 =?utf-8?B?ejBiK0hnN3U0ZHcvOU5uOEpjblNIUkJVdmlyOXc3U3RBcGQzKzE2bnlRekF4?=
 =?utf-8?Q?CCNoCOENJdE+LNSIXhCZ/JDf4RGJh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05uV2FOQlM3YzE0NlNya2pGWVc0RUNiejFRdm5GQURVYUxhUFFSV3ArVFdj?=
 =?utf-8?B?NnJxNWsyUVJwQVFldFo2TzVvNUpCTy80ajhEUlV6RFdRWHRCK2xqWjhIV0tU?=
 =?utf-8?B?V2JHNUhOV3RSUndpbXpIVWF4eFBJUHc2RmY0N3FlMHhIZUFtV3piNFhVMk16?=
 =?utf-8?B?TVVuNmNFWEF3TnNFYU9veDdLQzdhekFzdnFZRmdmeG85RFNXazIrWUYwT0ZY?=
 =?utf-8?B?d0VqcUxrRWlSMWJMUHZsZ3BsalVaaThZcWxwQkNXV09sYllnejdQUEVYUDVn?=
 =?utf-8?B?S0RQV1Z3czkyMnBkL09iL1dMZ0FTYlVmZlc2VTVaajVNbHhFZnBnTW84QmVM?=
 =?utf-8?B?RlUzbHZ1aVdmL2N4ZVg0Ti85OFNLbGUyV0VLdFR0ZkRsb0tVY0IzcU00RlNY?=
 =?utf-8?B?UXhad1FNV2swdGxkK0dsdHhaQUY1UWdWRVN0aXE1UWUzSjArMkRUQlJBelY4?=
 =?utf-8?B?YjRrUE00MHF6bmRuWUZ5NXJhNTlDeElWcnk1ZlZURGI4UXhLVWtUWWIveWxK?=
 =?utf-8?B?ZWloVHdxOGs1RVlUMWJBS2FUOWZJTVFMdHRVREZwWHZSQW1WUC9vNUdmN1JB?=
 =?utf-8?B?WkIvOWI2QVdmd3JZbU1BZFFkYTV3N1hhZ2FqaksrQ25tZ0V3SHJwenU2NzRh?=
 =?utf-8?B?ajFZUmRzNUpGK1hlMjNqS2kxYjlNaXYwMFNYR0xGUkZxemVnS3JWdFR3Mksx?=
 =?utf-8?B?ZjdMcWxUSWVwMkZuckpYa1JNZ1kzb3JDaHRJaGFVdVpFRWo4eVNldGpWRFFV?=
 =?utf-8?B?VEx6bUlvZDV2LzZkTHl5QWJ1Z2ZhbjJWSDhRd0VJalBwb2RJN0gxQ0pUSHVO?=
 =?utf-8?B?MHRlTHkyUk5taGJSem1TR0I5L1ZSSWFFbFVGQnVSRXZDZjVYR2U0NHp1Zk80?=
 =?utf-8?B?Zjh2dDB6dUNTMWVRdjR1dUorYXZRMmlnMXdDSU1TM2tQc0k4cWlTZy9pQlVR?=
 =?utf-8?B?aGVrdFlQS0RydGJ3b0gwWlR5YUs5UVJDK1hhZEtEbCtMa2dZK3dndFhzZnc3?=
 =?utf-8?B?WU9qZFRvYm4yL2JQK1lJblJlQklYY0FPMGl5K0FyczQwSXZHdEppZ081MjNN?=
 =?utf-8?B?U2Y5cENSTVNpWjc4LzZ1RTlWbTh2blZTYmtpMFZ3bHY1TWJ1Z3ZPTVRobTdX?=
 =?utf-8?B?aXVYM1B3TWc2M25xVS9xbXVlNHNBVkFjcUtUK2NOc3Z4RHR2R3BnUDhwdTVz?=
 =?utf-8?B?ejljaURrdkNFVVBscWpaNHlBNy9XYmowTnEvaVdRcXFNT3YyZ01IclQ0akpP?=
 =?utf-8?B?M0NKTUg0KzBuSjZKVlZpdE8rNzRVZnVibGlEWGoyN2JhVWlhRUszVUNlK3pW?=
 =?utf-8?B?UFEvRCtVQXI5L3FZWnpTUGVPUEJzS1R6eHBDc0c5amYzSnV2emNtZWU0MGFk?=
 =?utf-8?B?SDJiV1FpT1NlREZFL2xMNEM2NUJObmdta3BKeS9oMFh6djFBZUcxd3JabXlk?=
 =?utf-8?B?VlVpYlZUaGRuUWVrQ1B6V0hjQnBrU1Z6YmNnTHNMNzlZaWhHSml1dUx3TC9N?=
 =?utf-8?B?RkNXTlV6N0ZVVTZKVTNGVU9sODdVaHhCUWNPWE5LMmRJZ1RJNlRlcHliTkJs?=
 =?utf-8?B?Q1BjUmFLK0xCdjFLdWlMVitHRmhBcUc4THpwZ3hWTHVrTExMZHZQTWpzWjcv?=
 =?utf-8?B?OERYVXJBcTIxbzBGUXdjak5QU2hhS203UDRsWDZhYjRFTmFDcTFVV0JJeGtw?=
 =?utf-8?B?YTZoeXYrZmpqSWRuZTdrN003RDhPUmd5TE9yVnNNa0xEck9JM3pGNUltM2FC?=
 =?utf-8?B?c1VtZjNCZ09lcHVsK09xS3ZrekZMSnh4bGo4cklBRGh0cDY5aWtnV1pwOUF5?=
 =?utf-8?B?eUZBaWhDU0lKZEgrSkZ4RmRRSHFuWFJTcUh1Y0NkZE1GNktLYUxZV2pXRnRt?=
 =?utf-8?B?ZzBmWkFHTTNkd0hIVS9EbG9zV2hxaS9VM2ZQWEJsN3pyeDhQYWwwb2VLR3Zn?=
 =?utf-8?B?SDIxREtsem5yZmM1Yk9BaDlWZmovNU1QUThBb3VCd1I3WXFjeS9kR0xvblVE?=
 =?utf-8?B?d3phazd6T0NJNmgyUTgrTzhyN056ZndNT0xzRUU0aUNTVTNValN5NWtIemcy?=
 =?utf-8?B?SndGd3pUS1Z3VUR4V0VDdllYN1hYNmRpeTFobXhNdEF3NTI1Y3llSWxLQXFL?=
 =?utf-8?B?Q1dQR2dlODNHRmVmVUxqQlBEdy8reUQ3V2pJVVE5cTgzODR6SUYwRWhNWFdS?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf2da77-0e21-472f-2817-08de0b7fb5d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:13:47.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dulaP5N7KRs5UOhHVNvxKO1CwBAz3kDk9BNtrSLjjpyivKd/7euEoEsEbUAgK0FVbfpgkV1F+UwCvtBV67mE9EMlWv01/L5dCRzxQ7DAI4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041

This patch series adds IOMMU support for the Agilex5 platform by:

- Updating the device tree bindings for:
  - Cadence HP NAND controller (`cdns,hp-nfc`)
  - Synopsys DesignWare AXI DMA controller (`snps,dw-axi-dmac`)
  to accept the `iommus` property.

- Adding the SMMU (System Memory Management Unit) node to the Agilex5
  device tree and wiring up the IOMMU properties to the supported
  peripherals:
  - NAND controller
  - DMA controller
  - SPI controller

The Agilex5 SoC includes an ARM SMMU v3 with dedicated Translation Buffer
Units (TBUs) for peripherals. These allow for hardware-enforced DMA
address translation and memory isolation using the IOMMU framework.

Enabling IOMMU support ensures proper integration of these devices in
virtualized or secure environments, and aligns the platform with ARM’s
architectural requirements.

---
Changes in v3:
	- Refined commit messages with detailed hardware descriptions.
	- Clarified which peripherals are covered in the DT changes.
Changes in v2:
	- Add more description in the commit message body to clarify
	  device required for this changes.
---
Khairul Anuar Romli (3):
  dt-bindings: mtd: cdns,hp-nfc: Add iommu property
  dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
  arm64: dts: socfpga: agilex5: Add SMMU nodes

 .../bindings/dma/snps,dw-axi-dmac.yaml           |  3 +++
 .../devicetree/bindings/mtd/cdns,hp-nfc.yaml     |  3 +++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi   | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

-- 
2.35.3


