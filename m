Return-Path: <dmaengine+bounces-8032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25049CF519C
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 18:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD8B3072E85
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7A3469FC;
	Mon,  5 Jan 2026 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQRUByx3"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041293446B1;
	Mon,  5 Jan 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635452; cv=fail; b=ArHt66LBnvTv2I0JuVkkA6w581MkcXRIDlw/K72iC+wt1Yr/AiDpp6JE4jFFFuX1uiyx4gDmBgYG6RnyWolUnZ76v3KfUZinP1X5vPgrXLaa7UZ3E4EF/2eRaNLc9qwIXaZiXsf03TbGcxrSDYgIOGXqeq7jACz+7dFd6QVkzc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635452; c=relaxed/simple;
	bh=Gw319SlzrfSmyLYDvtlKviCDEp7fPnWS6qVUE03DKjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEwqMd7bZhfknJLNRIWd3F1gtjJGMIR6Uycy0sS2UERWLaFFK7bxTfzRHVF0wD7C+5o+7bsM14PD6j9JKMJoH/vDm9+mcmdt70lBm0Kc/1Vv/asL7cyfOUFGG1FDr7y+G4x80hBw5PCo9aTjylul74Qz9VhpVgr2WsUb2QR+7RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQRUByx3; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUQ6uT+qVENsUnCmwbl5KCrDDt6Wv0iTmRfu/KCdTtBwDZ4KM5gWJkKzHGYqTj7cCyaDc41TKFSFudIk9pnXp56q2Frtax/cm6Zi1cFqGcYFTH0FAZ0XSxHpsSJBJQBMKu/QA+2xjiHjdOO6EJNzo1AVEQN2qD/jvPkM+mAHRsMGMRyn8TOuK1j9znJ3Wb9EouNZnDYrT3aygcfZ21ppX7pcj+qMep8HFqs9598BswSeDQUNkfJvn/6YwB36Htq9BqKeqfNhuyely2LZ3ul2n6Ntj3LF52IHTXNXakHvBov+Iq8CiLhLpMhApDENVxGOO+fWtm4SFsgSDaGLaC/tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inN10ti9ocDaMkINSRGv9Mj6dc60mMrPAJYjUADwCW4=;
 b=e5J5Ws2aiAorwdH0TfVk37T1bsxN/+SavlMSIAowRS5lV2cMs8IS1Ba4D/hmpFn7QSXZIHAgfpuRn6ZRc/bk376qFzNKR/DQMHEvokzHVSi5VR3/7Qxgx2ipr1iduPgmjg+L1ZOQeecI/bOLPo0Hugd+5qu7SPm41PzKntYICxdq9APsFgqjiHTG2jaYefUrDoNWUG2yLThnoUKVbaoopZdDfo9TdIrhOYi0eRC+6ywD/4gerDg3XGMv7GwwydUHVAxoRRLdK6O9DYrE/iYzjUcKUcwJdNPLfuj9O2JXQMFvPfdHy7EVTDI7WMAI7qNYVc/jKMvLPjc3ot6Hs/ahxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inN10ti9ocDaMkINSRGv9Mj6dc60mMrPAJYjUADwCW4=;
 b=eQRUByx3ulNCHEetpgE0VIW/62R00MuWrcwVZTZQD10Wu/HmL17EjKdAlmVh2Mr1EspRQey+AkkTMlQZJGUPIrhjpdaFPEyF7WW2hphbG4Opo9KuWO12PZqWpSzwEdvTBHSx+km7FoGftZP4c+ou1h/Of8bP3S8i/rACx/r/2Kiak+jj2vI5ZqGIW2cIjSzH5qicIIYJQ6/DCrYUC8G1+AyNhMj77QTJMfhfXvUt58e5PK5WTWQvRWE7opazyabF2xPnUpqJXZEg9qy6ZBBbcnqgdu8A4wWnNkNtLP87HW3Y5kQoxJ7uyRLrhFuy1xJ+TGTYquB5Pk6vqr7PRqNdoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9108.eurprd04.prod.outlook.com (2603:10a6:102:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:50:45 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 17:50:45 +0000
Date: Mon, 5 Jan 2026 12:50:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 11/11] dmaengine: dw-edma: Remove struct dw_edma_chunk
Message-ID: <aVv57bqUAiX9Omeb@lizhi-Precision-Tower-5810>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>
 <5l2vl7sfnqjylmhve47pyi6tchqkn2n77zskkdisyynfxx3ftp@x55amadqlxph>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5l2vl7sfnqjylmhve47pyi6tchqkn2n77zskkdisyynfxx3ftp@x55amadqlxph>
X-ClientProxiedBy: PH8PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bb6643-bb37-44b6-6df7-08de4c82f3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZVK0pFa3d5VWZFNmwyZVFNaGFhSWlPSjhGMlg3M3dwZGRsNUVPWExxYWd3?=
 =?utf-8?B?VzkvZXdDWHNNdlFPYjY2YWdEbVFKV3RFZ0hmRml6eW51STR2OVNlZ05kYkVX?=
 =?utf-8?B?QzZSb2NJRmUrSkhkNEowaFBmS3pwaHB5VDJNWHpGRzhXdDkrNUpRR0c3ZXRT?=
 =?utf-8?B?RHNTS3FsNTNWcElnSkdiYjArVWpSOW5oVFRFZmRrRm51VHpOVlBBWHR5S01r?=
 =?utf-8?B?UjNCT0hnOW1waFk3aWVHQ1paaTRiSnpQMWRYZVZpR1ljRGExelZLbm5ZWFMx?=
 =?utf-8?B?S3REWGQ0dGdxdzBHb1FNQW45TmNlMkVITUhaMWY5Qm9tbERCdE9NNW00U3RP?=
 =?utf-8?B?bTROcGVFUjRjc2Q2ZWt6ekpGdEVkd1JMZXl3L21KWGdmdndYdWhzUW91cVYw?=
 =?utf-8?B?YlZyNEgxaDhKNFNBV1NNdTFvUE1WN0lUV1lDeXNOVFpuUDBuUFd1eWRzVVJU?=
 =?utf-8?B?NVhyb2F2ZzJJSlJ2ZWJDZlVZbVJHUXlIWlN6UGVSaGFtWHpESEtyRkFmdjFM?=
 =?utf-8?B?ZzJWTlZzT0lwQ2hFRFJwNm8wclR2SmE2RUNaL1kzZTRVNENoS2JFWWhtRWZp?=
 =?utf-8?B?czlRSkJxaVN6VVlUVUJiQzljT3hPOEZxbDE0V3RoL0R5NVVoSUZCdDBnbWVO?=
 =?utf-8?B?TEJvQW1UZVVobnNxb0FkVzVEL21QRXowMkFXV055MlRkVGMzZDI5ak5NbzYz?=
 =?utf-8?B?Q3Fmczk2dEdNMHdqVUFrNGtnNHVtRTFLNGo2cXlEeFE4MGFCbVU3cVA3VUJ6?=
 =?utf-8?B?aU0vT1hQeGJ1VUMrMVRJdDZRdVNBMTdHVDM5S2JoalJGYnRLdmpteERNVytT?=
 =?utf-8?B?bjVYRXl1TmJYcUxQOEloT0dQV0dnQnlkaXRiR3JQU1FlUkRNbEwyUjN2cTRI?=
 =?utf-8?B?TnUzVDNzZ1JSNmJ2Wnp1bWk5Mi84SC9Pb0h2RVExOUcrTmt1QUM4alJzMVYx?=
 =?utf-8?B?TEFONzdVVm1uQXRralRGaTkyZmhvLy8rRTI1VFZkdEZaNUYvSmNodzlxTUdP?=
 =?utf-8?B?cUJnaVpqNVNNTWtWUml3WnYzVnhvSEtoK2ZrUkpjTk1KZjNOSXlVQVF5aVVW?=
 =?utf-8?B?MDZTOUNzMzhQWXdvMC96YjFYSERyMkxFUEJsZitxRDBsRS8yc3JxSzJIZlZ2?=
 =?utf-8?B?bU9ZN2dvN2p3SHZMamVteFpOcG9HZFBOU2NSVmJvM0dPZHdxWGdwR3pQYXRl?=
 =?utf-8?B?dXZOMTNKUVRpMWRpRE1VblJ6MTZiVUxtclZmemsvUTZ1WmJVZ0hsZUI4MHlU?=
 =?utf-8?B?Z2psSC92bmI5K2h3SWsvc0F6TVMvV2hWUGxpOHVnZkgwRzBGS2hLSFU4RTM5?=
 =?utf-8?B?dzBxd0FoL3VuREJLY2ZrSkNWUjlrSzZ0ejNYd1lRell3UHFwQnYxY0NSekJz?=
 =?utf-8?B?U0NFUENVMDljWER4eXJDSzMyV3RwN2JKR3l0R1JpT1JQb0d3QVBsUUREbVJJ?=
 =?utf-8?B?RVlUL0ZlYVZrU3kyL1JzbDRheTkrVElOS0gvakh1R3ErdDRWUDVndnFlWllU?=
 =?utf-8?B?YnVaWitVYkErMVhjUktnb1M3ZHUybjJCYlBxTEhrb2xxbVB2Z2tJbjhSR3p2?=
 =?utf-8?B?V1BFRlY5Vm9qWlNFdDgvTjhuWXUxWjd2WllneXRtbExwaXVDY0pnQUc0cUxE?=
 =?utf-8?B?bDVobG9iWlptVVo5c2o1U3JwcW14N0Fnd2U2bkR1dEZJT0xvTHJLaWNFYSsy?=
 =?utf-8?B?S2szZUhPdW9sVklRY2RkZTBxVDV2YVhWYWc0SHJCOEkyNUVWcVd5RUZmNmhk?=
 =?utf-8?B?L3JXcWMyUUkweVJ1MCtaTDdTcW1wVHNnVGhzQnhzcHI3Nmd0RGhxdWIvNXlT?=
 =?utf-8?B?SjJLUXJIbU4wcThsd0h5SnJWWGhydzZVTG9TeURuRVl6Q2JrdnFoRk9WSHlN?=
 =?utf-8?B?VTVHcDBGRWsvMWcxWlVpWnprbzdSTVphRXNpdnJFa2pTOGV6bXlodVRCOEM5?=
 =?utf-8?B?ZE9tRU53bjgzSTNoS05Hd05vY25JcEJkdHpRZUJ2czlKM2hWZmtxWGttUWNm?=
 =?utf-8?B?VWJtZ09jR1ZqQW5hcnJIVkpKeGF3Tk5DN3hMZisyeTZuMEozZnFISnE1Q3Bk?=
 =?utf-8?Q?uEg5u3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUxzZjhJWmsyUDlEYXlmZTlNMlRSMFprK2RlRnp5amtNdEVYajdnMlFHWW5p?=
 =?utf-8?B?V0hmd1M2SFFDK2dmd2JUMko1OHh4ZTNja200TXRtU1NSYk00OFBZSGVoeW9q?=
 =?utf-8?B?UFRQMEwyNk9jbVZoMXFFNHc0QmpKazZQY090Z2RUZmdrdHoxc05wcHJ1cFFr?=
 =?utf-8?B?RWNEZ09jS3lNYkRRQ05qTE1CZ09PQm5hQzJwL055WmlhWThnaVNwZ2NsazBW?=
 =?utf-8?B?S1N0Z3VTMFQrSm1aYW9iUXlKdFJ2QWkwa1VOUDlGWGVrSHZKRXo5YWpGeVdr?=
 =?utf-8?B?bWFXWFZXNU5QRFRLeFc1Vzc4N3hYQWJhOVFWQ0QvT0s0NStMVWRHSml5Y1JK?=
 =?utf-8?B?WkZtVGxxQ1NHNzVHRHRFb3QrRXNDejFZT2ZJMVEwVm9mK1k1VGFFQld1ais1?=
 =?utf-8?B?MFZ6ZUhXNXlleXlZUUQzYVFYSTltL0lyekJuaGY2eVJ3UjBwWUk4ZThuT2Mz?=
 =?utf-8?B?QmNGNERPMnJhU2c1Q0hwYnlMT2s1UXgybERyaHFvOVg0YWhYR2poMkppelNw?=
 =?utf-8?B?Z2lOajVPS0I3V1hXdDhicDA4ZTdZSm9WQXJRZ01Ud0lIck9oNTFGZ2wwc05K?=
 =?utf-8?B?OTgzVlFDeFA5amNyVFpkdGlFMmovZHY2NUdvWncrNjdVcUs0UzFsdm5ZdDZM?=
 =?utf-8?B?c1RmSnB2eEhzZUJ6K2haNlBIWDkrRmY5TTZzVFdIdjFFVGg3aUhXTEs0Yko4?=
 =?utf-8?B?Y0wvS05TTkxXeElZQWVaaVFpNE52RFYvQmtxbm5uMVhSR1l0NHNiUHduV2hI?=
 =?utf-8?B?VXRiU1FNQjQvQlhHTmZULzRDR3I1K0FyYytPdDF0dmxmVFpMMzVhQWRDYTJS?=
 =?utf-8?B?Njk5ZWZUQURQUkJLaG43MFNtY3hHT2lKdjRXdlJlMW02TDNmL2dBSzFsVU9z?=
 =?utf-8?B?U3hYR1cyZWppWUIxb1hza2gvMkRzT1RTcy9Tc3RsZnZ2VWpubC9hWUlFN0U5?=
 =?utf-8?B?aUdrdmhYd21BdWQyVFkwdXUyWmR1TnR4Mk44M1J3dGgvcUh2VVpGblZwb0V1?=
 =?utf-8?B?NGlHSGZ2cllyVWkyWWtWR3kxaGFpZGo2YmdUWDV5YWZMVjN0M29QQ3VtUXVq?=
 =?utf-8?B?OW1lcXQ2RVZONm52S0dGSXh3UENra3REVzI2TlErOGJWSDZGcTRldW5MYVps?=
 =?utf-8?B?bExVdFNSZmg0QUVkdlVDV2EyQ1VtRXJaejEwRnBNV2dsaVQyN2VmSWtNT21o?=
 =?utf-8?B?VXdNMWZoczFuRHB6Y1RxU2FXMUhEOEQyL25ZVUJDcTJjRXVNR3FYLy9VSitV?=
 =?utf-8?B?clNzNDZzTTZwTFdQY21vWElYTmdSVzh4SmNWYkxTMEVNRVkzOVl0Y3ZqWWJN?=
 =?utf-8?B?UmwvRkVzcmV0b1lUaU9KeS8wK1RQNjdTcTdpZjRHVnYrRnJQZjhqUTFZVy8y?=
 =?utf-8?B?SzVob1p6NFNkNDdaZ2RnWjZ1R1Nabml0UUlQZjZlZ2pJQ1N0WlpkUmZ1QkRI?=
 =?utf-8?B?QzdMZUhSeGxab0E1K25xMkh3elhFdDhXcnR0cWIvdXl0NTBpaUpVOFNBMGl4?=
 =?utf-8?B?NDJnYWhxOUxLVjRSekJzSVpYUDRsR2FVcGZ0OUxDU0NEakVhbkYwUjBWMGxW?=
 =?utf-8?B?Z213ZVFYb2xyUTVtNkp1KzZLQmlYRy9ybVprVHdJRGduem1xUkdTaTdLMVRk?=
 =?utf-8?B?cEt6L2lNc1VYa3YxVjVoQ3VNZUFVZ2dERjFQQ0tnM2FRalVZNnRiTlkzdmFa?=
 =?utf-8?B?dDdyRmtnT3Fxamp0ZUFuWTd3cmZ5U1UrbVhCVWxiTVM0aW8yazJTWFVucHR3?=
 =?utf-8?B?ZUQ3RHlmZXI5SjhHYUpoZVhoc3JtUDlhV1RzTC9ZNFgxYitxOFRoQjFyRUZP?=
 =?utf-8?B?RmdtaEUxUS9wbWZDUGVkbkVNcmpvOVA2YUNvV0NmYUNqWlpEK05EVUU3d1BH?=
 =?utf-8?B?MCtGc29CUnI4eFBxRmxCaTIvVHAzMmxrdDQ5eWNPdGNWWFMzS3RrK2IwTUlo?=
 =?utf-8?B?MnRTeHhMRXZUb0RvdC9xYkVvc05kQm5ydDMzV3pMTXl2d29yZ0tQRlhxanAz?=
 =?utf-8?B?MXNONFB4UG5mZW1ueEdKamEwTzJBUkJNQ2JRL2tCL1Jrc3NQR1pUUDZhSUxF?=
 =?utf-8?B?OEJMNkVFbElkMXI2ZUZXdW9YVG11cE1DY2doVTJiUDl5Q3FRb3c2UStvQ2RS?=
 =?utf-8?B?K1pXMStxRnBnSkhBbzBEMUFhS2RZSkdvSlFYeEoxMlhGb25FbW5XYmJIRklE?=
 =?utf-8?B?amJJd3h1T2I4K05jWGpxdzJxUUpncFliYVlmbDNGSjA0VEtnM2ZmdFlmcVJp?=
 =?utf-8?B?R2svYkM2K0Y2MUlDV1pSZWpCYzBOL3BJaUZ6TE9XK05LcmY4cjZGTnRzUXNv?=
 =?utf-8?Q?Iluiz7yGybEaQkaoAF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bb6643-bb37-44b6-6df7-08de4c82f3d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 17:50:45.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdaDTFyliADGZALRaU5f8q9fNB4NgopLeNgWlxAAvI1hyMM/+1P+rttkSB+anNy0b+TMq9VNaZAnZOM2Pw4JAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9108

On Tue, Dec 30, 2025 at 10:31:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 12, 2025 at 05:24:50PM -0500, Frank Li wrote:
> > The current descriptor layout is:
> >
> >   struct dw_edma_desc *desc
> >    └─ chunk list
> >         └─ burst[]
> >
> > Creating a DMA descriptor requires at least two kzalloc() calls because
> > each chunk is allocated as a linked-list node. Since the number of bursts
> > is already known when the descriptor is created, this linked-list layer is
> > unnecessary.
> >
> > Move the burst array directly into struct dw_edma_desc and remove the
> > struct dw_edma_chunk layer entirely.
> >
> > Use start_burst and done_burst to track the current bursts, which current
> > are in the DMA link list.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 130 ++++++++++++-------------------------
> >  drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
> >  2 files changed, 57 insertions(+), 97 deletions(-)
> >
>
> [...]
>
> >  static struct dma_async_tx_descriptor *
> > @@ -551,8 +499,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
> >  		return;
> >
> >  	desc = vd2dw_edma_desc(vd);
> > -	if (desc)
> > -		residue = desc->alloc_sz - desc->xfer_sz;
> > +	residue = desc->alloc_sz;
>
> Now you dereference desc without checking for NULL.

It is impossible that desc is NULL if vd is not NULL.

static inline
struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
{
	return container_of(vd, struct dw_edma_desc, vd);
}

Previous check is reduntant.

Frank

>
> > +
> > +	if (desc) {
> > +		if (result == DMA_TRANS_NOERROR)
> > +			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
> > +		else if (desc->done_burst)
> > +			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
> > +	}
> >
> >  	res = &vd->tx_result;
> >  	res->result = result;
> > @@ -571,7 +525,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  		switch (chan->request) {
> >  		case EDMA_REQ_NONE:
> >  			desc = vd2dw_edma_desc(vd);
> > -			if (!desc->chunks_alloc) {
> > +			if (desc->start_burst >= desc->nburst) {
> >  				dw_hdma_set_callback_result(vd,
> >  							    DMA_TRANS_NOERROR);
> >  				list_del(&vd->node);
> > @@ -936,7 +890,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  		goto err_irq_free;
> >
> >  	/* Turn debugfs on */
> > -	dw_edma_core_debugfs_on(dw);
> > +	//dw_edma_core_debugfs_on(dw);
>
> debug code?

Sorry, forget remove it.

Frank
>
> >
> >  	chip->dw = dw;
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 1930c3bce2bf33fdfbf4e8d99002483a4565faed..ba83c42dee5224dccdf34cec6481e9404a607702 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -46,15 +46,8 @@ struct dw_edma_burst {
> >  	u64				sar;
> >  	u64				dar;
> >  	u32				sz;
> > -};
> > -
> > -struct dw_edma_chunk {
> > -	struct list_head		list;
> > -	struct dw_edma_chan		*chan;
> > -	u8				cb;
> > +	/* precalulate summary of previous burst total size */
> >  	u32				xfer_sz;
> > -	u32                             nburst;
> > -	struct dw_edma_burst            burst[] __counted_by(nburst);
> >  };
> >
> >  struct dw_edma_desc {
> > @@ -66,6 +59,12 @@ struct dw_edma_desc {
> >
> >  	u32				alloc_sz;
> >  	u32				xfer_sz;
> > +
> > +	u32				done_burst;
> > +	u32				start_burst;
> > +	u8				cb;
> > +	u32				nburst;
> > +	struct dw_edma_burst            burst[] __counted_by(nburst);
> >  };
> >
> >  struct dw_edma_chan {
> > @@ -126,7 +125,6 @@ struct dw_edma_core_ops {
> >  	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
> >  	void (*ch_doorbell)(struct dw_edma_chan *chan);
> >  	void (*ch_enable)(struct dw_edma_chan *chan);
> > -
> >  	void (*ch_config)(struct dw_edma_chan *chan);
> >  	void (*debugfs_on)(struct dw_edma *dw);
> >  };
> > @@ -166,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
> >  	return vc2dw_edma_chan(to_virt_chan(dchan));
> >  }
> >
> > +static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
>
> No need of inline.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

