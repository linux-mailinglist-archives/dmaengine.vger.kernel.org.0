Return-Path: <dmaengine+bounces-3974-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD39F2B44
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF091883F58
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E01FFC5D;
	Mon, 16 Dec 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lGHU5x5K"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4A1FFC46;
	Mon, 16 Dec 2024 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335918; cv=fail; b=jt6lZ6ERLTiw0pSCeNL0qB2DVlU4gVdjF8C+p1DECDOD0SqtFwE/l+XNsIVp8eEiZCHK05RhGbjwMCYq+g7etMcwUL8Ug2Q3WRXfTESPK/ll22zrPI9XkxhNHXHkiEaT9wGG7yUtzx0cxgyqOdlpAnUYsfj43qyOIecBRtYSQd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335918; c=relaxed/simple;
	bh=hoC/8j7Aw2+ZwBS8LuDJ4kHSWCEk88ZD9MGKraAll0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+v12qy6CyEd83HGxmkJwO1jK/fwaI5iVDyZKp3U2EqjSCVd4Jdii4iPNFZgqHxfMOab9yepLbWpGceMKk+NKpK+nZZgR3cJBMkiwNSCXWsa+vJOni4lMXfOrFfMpX2Rqu47q8QHGAiN3mdcV4UiNIVDy6v7K3YSfz20hQk4iUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lGHU5x5K; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMGGiJBXUpe9NsH/PEknIigkdvUGLFBh+7YuEOPeExrqUi+mDhn6nG/PeBuc2uHUAiH0Z3TP2cNPvTPcvX9Ofk1ezyoOZb9g9IzulB2Ui9wv/+uHa4UjTWj7kZ1EuP81cBanz6GHr/RmMuFsguBmC/0FNP4iLQg4gppgHrAFJqZyASHRGzCT3iXfDc8vn3yXjZAJ9Bgd/APy21WQN/Ooy6wDoFGD/086o5gYTPGveii7SNGvTgQlk553MKfPpFZotwPC+djeIAENa02eat/iiYJhRAXPPH/8JSLkOW/bIhTf2lfA56aH/iLIv4bCVBRseu5t/VTcBGcsFUOBgGPWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpjL3UpDhlGU8cK6OFygpbSRbkq5xgfG+Nf5MiagAt4=;
 b=McjjEn+u/49DQaXMT7cmOxNbUrS8xirY0AqgCVMHtW8d/YhUOMiDeYH6S9OzmhdBI2Pnoptwwh0VxEhWFSDy4vUei31lR6OP2I68EfWqQWZzkLIdZtuDo1uDb8Zq+slUeqNMU7OD86wv9Z75711p4599uGSypAkOiYF2HAPpcwloKIcdOednOicejDrUZ+L1xoidpdlMSSrm81UEhHhHzz0I9WpmY7SiTEnmuL3cFYbXITYX0pUAxFgtfcCORHZMir8NsiDKJDPjkCxtDK4DC4tzQcKgov6KjPTZRB8m/9Sw/AcGVbbESlYAkdJTjMEuvQbT7WXuXAPRASIbz7pCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjL3UpDhlGU8cK6OFygpbSRbkq5xgfG+Nf5MiagAt4=;
 b=lGHU5x5K6Li8gpcNNe0qH8L/SHafOod5xNsz7rU13trtl4mRG1K1bSy/UU/R+pcJfqOBCBl4YkRnveea7IGjeHKejK3LPOpv5pSn+YMqbmMoidPMLGlTTS1eDDE0N1t0mf7qZEM8ILjpopFiidHwGG7DEE38a0Na4CKbdCQW4s9cwZ5q8OyUAFa/clSf0JtazsrKuecgKi6xCmar+OIAUJCnInOYHlP6kM7y25nrxQxqhSboTJyLC1e1nFilzDnXcHTkMVIyyugLmPTCywMXrbmgXoBTYhtBIrnTrKhhoVCTFwH6Lq39pFzioTMYgwrbAK7rxmUt5nuPV7tPrJ2W/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:29 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:29 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH 3/8] =?UTF-8?q?dmaengine:=20fsl-edma:=20move=20eDMAv2=20re?= =?UTF-8?q?lated=20registers=20to=20a=20new=20structure=20=E2=80=99edma2?= =?UTF-8?q?=5Fregs=E2=80=99?=
Date: Mon, 16 Dec 2024 09:58:13 +0200
Message-ID: <20241216075819.2066772-4-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:208:be::25) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5d47f9-1d7a-413d-7f6f-08dd1da76dd5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEpGMXl3bnd4ZC9pM1BJaWNzSlF3VG16cFEyR0lsUjlLaEVNamtqZ3VvT3Zv?=
 =?utf-8?B?Q3lscDZ4ZFF0elJrTFFuT21OVXhHUnpFTVd4TmZTMDVVZi9qMXF1T1ZET2Vt?=
 =?utf-8?B?QTlMQXZOazBpYnIzU2NIVFpNME5vOTEySmZaQWFRL0o4YzFCeHRxQ3ZiaHho?=
 =?utf-8?B?MVovNjE2NUdEOHRxV0lyTy9BbDFUTTVHMkl6akR0bnRjMUFaUkJuNENpNjlh?=
 =?utf-8?B?UnRaUnMrN1pOSFc2aGZqaE5OVnM4ZjVKZlczVmxzQU92QVQweHN4TE05bzF4?=
 =?utf-8?B?YUNFVC9ISitwUHZaL3VIS3JBTE9KK2liNHM2STMwS2p6Q2RqUkhhcTkvR1Nm?=
 =?utf-8?B?dW1TWXdrM2VVOUFHNy9MSVhTUGhhU1FYK2ZPb2JqUDZETUVCMGZ6SmlFV3c5?=
 =?utf-8?B?bVFqbGtaeXpUQ2ZRWTdPTFp6MFk5VlVZRFQyaWtXUVhFOStqZHdSWFNGVVhJ?=
 =?utf-8?B?RGZtTE1kd3gwNGhIZWtkdjByMEtpNnNhblptRnVKV1A3dVlsb2FQK1hCTitx?=
 =?utf-8?B?dkw2Y0NqeXlYajNDTFZMNFdVQzYvbW5nS1ZxblpwcUU0NHlFeDJnVm4xbzA0?=
 =?utf-8?B?ZWNNcFNtbytCL3BjdGg2WWV4YXAwWExjQTNRbHVrb0l5d01RT09PV0VGWUE2?=
 =?utf-8?B?Y3dyaXhrektBRnRlZ1FwMlYrLzVrcDY1eEg2N05mM0hwc0ExR3RVdDR1NDZr?=
 =?utf-8?B?NVl0SG5XQ0d5VzZwVGZlcXhhMzZ3SWZkQVRjL3JvZ0dicEZsN0ZZYWZFU25Z?=
 =?utf-8?B?SUhXdUZQVU92TlNSRVBKd2tLWC94Z2lnbC9TbmVmbUN2RFhqSlUrOHRPVmNW?=
 =?utf-8?B?Um9PYktmUzhKcHZmSTdkVDBsMEFrL2U4UEFCZm5FZHEzUXNtYm84c0tZUlZE?=
 =?utf-8?B?Y2d6ZkZ1R3ZEV3ZmNWxKenNEbTQ5YXJ6TGd5V0JJOWZEd0lBUGJHaVFoR1hZ?=
 =?utf-8?B?a21QbThQYXgwbFhSUnZxREIrNXVwNm56VGk3TDFZY01vZjFIeTZyaHNXdFNX?=
 =?utf-8?B?akw1RjB4cWtUYnRzNXJTOGxzNDNFdlMyZUtNbWpHVWduUE53cks2bHNhbjY1?=
 =?utf-8?B?ejV3WTQvb3hzL0lKWHZNVnNkdjQ5Z1U2WFhiWmEwTmxJc0psb1RaK2lsNkhs?=
 =?utf-8?B?RWExOEQxTXRieE5hSzgvNVd3bGFKVU1DdzFocENDR203OTNMU3I0cXVJZFV3?=
 =?utf-8?B?QWVmd1RJdEk2U3gxZHorelRJc3h1aHEySDExcmFjdGFyWENvaHUyK0FhWG96?=
 =?utf-8?B?aUsrOFVxOVUvZ3d5elVZVEVTak4xWndVbTJHaHI1R3BzcGgxSDczY1RocTZH?=
 =?utf-8?B?M1QveUV0cXZKQVJWSTBaek9MNXJBS045bGM4clpNQkpVRDB5MzMveXNXeFZF?=
 =?utf-8?B?Snd0MEZ4VmMzL0xvaFhsS0RrVnNvcE1yczA0Q2FvckRvTnAzbzZ5OTRySUVj?=
 =?utf-8?B?R1N4aEhTSWFtemEyN1hwZWZrVHJ0RExmc2F1ZXIrcVNkZFZFbk1HM2xxVllu?=
 =?utf-8?B?NDFVV1VaNVlxQUVsdlZEQm5XV21SbkxjTnprTUs5QzlaVmlyZHVGdlNENTl1?=
 =?utf-8?B?cko0MFZMdEs1TnN1TWZaQ25FK2ZQc1ZlQmFhWEx0bkJoTEtVcFpDd0NqNGFv?=
 =?utf-8?B?dXlnSkRHTFZEc2hJOXhBZ0NTZzZEKys3YzlXL1B0N1hLbVRRRmpJK0RsblFQ?=
 =?utf-8?B?OURHVlpuenFBWHVxL0tXOStZQUlEeXRtbDJLVVJVRHd6dDlDaWpHK1BLbUFw?=
 =?utf-8?B?U0ZwU1Ura1dEUFg1TkszcFFZenFTOW1PTnJxUGtlTGtxaGZxL01vdTRWaWVu?=
 =?utf-8?B?dmtRNHVWZjlvcU1LdDgzQ0hhTHE5VFZ3OEpobDd5cGF5VDdJdWlIVUhNdEFQ?=
 =?utf-8?Q?HDtpVs2pGhOa+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWo5WTcyNGRHalBFZ3FkU1NVVlFtRVh1azZ3MEpYM2E1NFBTMWwxWDNDYyt1?=
 =?utf-8?B?WDY5bVZZdFpIL2tzVjRnYU5ERHVFTmhBeXpwY2t3a1d5QWVUUkRQSUo5M245?=
 =?utf-8?B?RkFrOUdEZGpTU3JSZk1VZkxUSGVDTnUzTjFpSWJmY0pRbjlVSDlpdGdCUVJ2?=
 =?utf-8?B?OStTb0hYQXUyQnllRk5OY2RGa0FPbm0ydzFzQnNzWVZmTEtidUs2dkZSWHdM?=
 =?utf-8?B?RC9KdURTdHloWW1NSERXSEdCdGl2bS9aN0JrNms4MnRrYkFPL3ZiVWdsS01j?=
 =?utf-8?B?VlZHbDJuYy9jZng3RWRMQ0o1d2k1SElnTTcxTWthL1ZFK1RNaHNESTRZTWwv?=
 =?utf-8?B?TE1zemdvVGJVcU4xSTV4WjJNMFFjTkVXbUdFUDhaWGRINU80K3hsd0tVS3Rl?=
 =?utf-8?B?bmZuUzNqK01TNFFwRXM5NkR5em05alZoVHhlM1B4d1AxSDViZ3c0TFhlK3Rn?=
 =?utf-8?B?N3V2UDJRZyt6aE8vWXZOU0puTW5jSFBNTmVoTjVDc0ZsNFJaQ1k0V0VqUTcx?=
 =?utf-8?B?eGRseldKZDRkZXZKeE5rd1QrbzdFdjlnckpieDVldk1VVkM4c2d6YXdjUXpG?=
 =?utf-8?B?aHN2QzhoMXJ6cEV5RjVrb090UjFFUk8rNTYvKzRsSzh1Mkp1a1JnSTZ2dEJ6?=
 =?utf-8?B?dFMzNndVMGpSeCswZVcrYVd2Z0E0OVlxOS9UYkp4QmtoOWZKYzdydktDUXdo?=
 =?utf-8?B?eHJ2M2xseDduWGtGdWVFNGd1alE5VzVlNzRWYUhMRThLWmNZSDFDaFdKV1Iy?=
 =?utf-8?B?VUcxZTlXdExRNHZxbUNYcXFBS0NMbk9XeVRUemN2WFhWejNiREtpODNHU090?=
 =?utf-8?B?TFlKRWpaK2xHYUhtM20yNEVQdllONFduSTlISmZaSEN6ZFpWazg1WVZnZTdH?=
 =?utf-8?B?WEd0UkdiMGl1TE82aUFpVm5XUkRoeXpYZ1huYzlDK0ZpQmpHV1V0V1Y0ZTdI?=
 =?utf-8?B?VHN3clV0YkRPeTFMVXNSYnppa05nM2FPL0VLd1JsNXZ5RHFVZ0JmQmd0bUdQ?=
 =?utf-8?B?OG14RUNGTEFRbG8yV1U2NmRrcG9KTElLemVOVWIxTXJ3VFBlcWUrN0k4MXRt?=
 =?utf-8?B?Tk1NK3NQSEVxTDQ1NnFLcHdkeUo5OUd0dDhZbDZmWk1LVHZkdnhlV3pqeWNV?=
 =?utf-8?B?WnVyczV3dUFaZGpOczVWMUtGeCs0aTRkZWJlQ3FMak1QWE96SzFPdThUME8y?=
 =?utf-8?B?djEva0xJWFJYSC9XZklKR3VhSXFuN3V3c3dSbnh5aFl5YlNEZ2w1bHB1L01O?=
 =?utf-8?B?SzZ2djZscXF2RTg1b2g2VUJXczVoVlhmaUh6UUtPZnhVNlVoWXFpQ0k0U1Fs?=
 =?utf-8?B?T1gwdWx4OXNnMGh0djRUS0RSMEY4NWRnS2ZkZlhTc3MvZExXTXVJandiRVZx?=
 =?utf-8?B?UHpkSkpIMWJydyt0K2hqSTYvbEZOTFpzejMreThxbjUrRFd4dXIxUWh0R0h4?=
 =?utf-8?B?a2lzYWZFaDNia3NVREdQRkowZTNNemRmSGpUc0VMZm52NlhEdC9RSTE4dnY2?=
 =?utf-8?B?THp5WnlITGEveC9TREozSWU0dXM1Y1B2cHJkUHdQcEdHUkEyYnN4d3U4RDRW?=
 =?utf-8?B?MmpUN0RSeERTQlRhakNRRXBtZWcvYmFJWlVkRlpFd2RYNUtySEdVRVo1dVMw?=
 =?utf-8?B?OVJtc3pRdi9FOWFPWHJBMDJqazEzVTFybEdsaDRCQU5yWTk3MWJEbEpKQW5i?=
 =?utf-8?B?RDFLamdta3BiY3preVMvSjFpQks5SUloODhCWEI3Y2lpOFhiVVU1T0VoSE1V?=
 =?utf-8?B?L2xCU3YyZXBoKy9kUGx4RzFBTkpNSE91SzhUMTZUOGlvbDhyaW1hK0hqRHI4?=
 =?utf-8?B?eGVNWURMdDhUeWxVUmF5QlRoaXVmTit5SHcwUFZITWpVVG1BNzdxMXdVY3Q0?=
 =?utf-8?B?SDJSZ1RBVXBwL2JuSTVuaXQvYmM0NGZ3RG9OZVNYY2p4ZzVMZ0NsVWY0OGha?=
 =?utf-8?B?OTczK25KNHBLamJSVWVDazVDSmIzdGtVZXNqOFA3OEhSdmtlWEl3b0hZaEpU?=
 =?utf-8?B?SGVhOHhxcjFJZk1iUjlJZHJmeExxY0FzRnE4LzB2aS81TTIvdXlhR1RoSnk5?=
 =?utf-8?B?Q1dvZ0ZwN2xwVU9NdEdIM2JRNmdKYTZIZ0JzMGN2aHY4NzNqcENmOEI4Mkk4?=
 =?utf-8?Q?WkpzOZTUfUts2HmWwbTqeyYuP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5d47f9-1d7a-413d-7f6f-08dd1da76dd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:29.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0TIst55EVfbhdjfymyy7aD8Yq6NsH68uY+4CR/23CReWMp65oN1taiCaA1dpgfWaT4cPUTB2HrR5+MzqqHicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Move eDMAv2 related registers to a new structure ’edma2_regs’ to better
support eDMAv3.
eDMAv3 registers will be added in the next commit.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 52 ++++++++++++++++++-----------------
 drivers/dma/fsl-edma-common.h | 10 +++++--
 drivers/dma/fsl-edma-main.c   | 14 ++++++----
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855..b132a88dfdec 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -108,14 +108,15 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 		return fsl_edma3_enable_request(fsl_chan);
 
 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
-		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
-		edma_writeb(fsl_chan->edma, ch, regs->serq);
+		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch),
+			    regs->v2.seei);
+		edma_writeb(fsl_chan->edma, ch, regs->v2.serq);
 	} else {
 		/* ColdFire is big endian, and accesses natively
 		 * big endian I/O peripherals
 		 */
-		iowrite8(EDMA_SEEI_SEEI(ch), regs->seei);
-		iowrite8(ch, regs->serq);
+		iowrite8(EDMA_SEEI_SEEI(ch), regs->v2.seei);
+		iowrite8(ch, regs->v2.serq);
 	}
 }
 
@@ -142,14 +143,15 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 		return fsl_edma3_disable_request(fsl_chan);
 
 	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
-		edma_writeb(fsl_chan->edma, ch, regs->cerq);
-		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
+		edma_writeb(fsl_chan->edma, ch, regs->v2.cerq);
+		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch),
+			    regs->v2.ceei);
 	} else {
 		/* ColdFire is big endian, and accesses natively
 		 * big endian I/O peripherals
 		 */
-		iowrite8(ch, regs->cerq);
-		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
+		iowrite8(ch, regs->v2.cerq);
+		iowrite8(EDMA_CEEI_CEEI(ch), regs->v2.ceei);
 	}
 }
 
@@ -880,25 +882,25 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 
 	edma->regs.cr = edma->membase + EDMA_CR;
 	edma->regs.es = edma->membase + EDMA_ES;
-	edma->regs.erql = edma->membase + EDMA_ERQ;
-	edma->regs.eeil = edma->membase + EDMA_EEI;
-
-	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
-	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
-	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
-	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
-	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
-	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
-	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
-	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
-	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
-	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
+	edma->regs.v2.erql = edma->membase + EDMA_ERQ;
+	edma->regs.v2.eeil = edma->membase + EDMA_EEI;
+
+	edma->regs.v2.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
+	edma->regs.v2.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
+	edma->regs.v2.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
+	edma->regs.v2.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
+	edma->regs.v2.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
+	edma->regs.v2.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
+	edma->regs.v2.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
+	edma->regs.v2.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
+	edma->regs.v2.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
+	edma->regs.v2.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
 
 	if (is64) {
-		edma->regs.erqh = edma->membase + EDMA64_ERQH;
-		edma->regs.eeih = edma->membase + EDMA64_EEIH;
-		edma->regs.errh = edma->membase + EDMA64_ERRH;
-		edma->regs.inth = edma->membase + EDMA64_INTH;
+		edma->regs.v2.erqh = edma->membase + EDMA64_ERQH;
+		edma->regs.v2.eeih = edma->membase + EDMA64_EEIH;
+		edma->regs.v2.errh = edma->membase + EDMA64_ERRH;
+		edma->regs.v2.inth = edma->membase + EDMA64_INTH;
 	}
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ce37e1ee9c46..f1362daaa347 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -120,9 +120,7 @@ struct fsl_edma3_ch_reg {
 /*
  * These are iomem pointers, for both v32 and v64.
  */
-struct edma_regs {
-	void __iomem *cr;
-	void __iomem *es;
+struct edma2_regs {
 	void __iomem *erqh;
 	void __iomem *erql;	/* aka erq on v32 */
 	void __iomem *eeih;
@@ -141,6 +139,12 @@ struct edma_regs {
 	void __iomem *errl;
 };
 
+struct edma_regs {
+	void __iomem *cr;
+	void __iomem *es;
+	struct edma2_regs v2;
+};
+
 struct fsl_edma_sw_tcd {
 	dma_addr_t			ptcd;
 	void				*vtcd;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 9873cce00c68..0b89c31bf38c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -36,13 +36,14 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	unsigned int intr, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
 
-	intr = edma_readl(fsl_edma, regs->intl);
+	intr = edma_readl(fsl_edma, regs->v2.intl);
 	if (!intr)
 		return IRQ_NONE;
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (intr & (0x1 << ch)) {
-			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
+			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch),
+				    regs->v2.cint);
 			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
@@ -78,14 +79,15 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 	unsigned int err, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
 
-	err = edma_readl(fsl_edma, regs->errl);
+	err = edma_readl(fsl_edma, regs->v2.errl);
 	if (!err)
 		return IRQ_NONE;
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (err & (0x1 << ch)) {
 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
-			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
+			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch),
+				    regs->v2.cerr);
 			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
@@ -216,7 +218,7 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 {
 	int ret;
 
-	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
 
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0)
@@ -281,7 +283,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	int i, ret, irq;
 	int count;
 
-	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
 
 	count = platform_irq_count(pdev);
 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
-- 
2.47.0


