Return-Path: <dmaengine+bounces-4037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E729F797E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145E816B01D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E96222570;
	Thu, 19 Dec 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l9qpKFuF"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713D4594D;
	Thu, 19 Dec 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603884; cv=fail; b=fuxtmxZ7ZfcV2nlToBqXhs3jIS4SpZN4vIhLglewntU42r6ks9LH/qdm5k1mY5guOicsBUJu8TgG6TdwaEafgVWTBuM+PhkyhVkDFByZzXJjGRnMicisDKbTBXmEjUnHc+wWvNAUkg2Q1b025B/nCm9R1hVaAb+xqIHQFQpzisg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603884; c=relaxed/simple;
	bh=YTwPqi8UIlyS9lCjoDaQyipgC0uuabzr/F951EqJskk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UNrL0sHBB6Zi+EOy2Uo+n0FOQnwAFcInffZVtqrSJ1NlKzGT1btx54UmsewijlaGZcKLoBBkP72PnlGsYZQZbf//dQ8GKbK0yaj+01y1MCfo6W58CShSD9oAWvyg2KuLDxudTFOfrifsj/mIPXokx6PMnIh/h7lmSrWIQM4CDQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l9qpKFuF; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo7XIY8wx24zzfyGFbzXpI3Z4muSphAQ0jwtfFeno+wlpMRlCVTRUBpFBwZgqZhfQY8cDoejA/IUOh90xovAGz4uU+yWYBvC+D85AEpBMDQsf4ewyGu657JDwwmE/NKq9T5fJ8Is60FUKJpMCf8iS/Dc7spfmcfLzSToPyjVg+kIZ0rX1kM4Vnoj1ch7iY2wIuFiCFPMpN3mKVQ6lyhlVXH8sU/vEnOan9lbkrje8lhdkgqZurP3vTLcHiGrZSUo4lj3laUZUGgtYHV4SElIiCC4AhnEmR+rCDyzlxKYY5z7ACkDfqyqJy517uRBkr2HrVwgFJg+ZvumIKEbqsbn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leg0tLM8PFWFftUHoR3c4m4WqJzq7eDIrrmoWHMWgLA=;
 b=ly/deCtByLS7xCIRCzwanGCG1A2qvV5zEYuZqNR8Yh0i2nsd5SG5b+PUxY3DHBLadQ4mJHSBd3ke9GyVHx06i4jknKrlV+LMYLe0mt99KoNQkUdLQmt0hIAojq10bhemVgGFlQfxbA43QHy4ZatbaDhDNRZtHvSSzNTdFGfuLBZkJkDXhFQU97xfEjJzWyplMPXHVDOs888rpm3bmrKMChmECZz2Q0jXl8C0vNOuGYY18QTXaurQMajpkh24Vay27Pgwv4I5rhD1MugkwT8AMPMrD8G1lnG/nWnc3ALCpr/nB9EjmbPTnL0ZNdI1ZQIUmvLULzCzqy+MKnacNoIVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leg0tLM8PFWFftUHoR3c4m4WqJzq7eDIrrmoWHMWgLA=;
 b=l9qpKFuFmmLKeL64K8Sg7DJAAslyWaWxCg05dT91RlxqV/WyPwrIffk0lx7s91mg7MzzisfkkhLa4hxojvwL6UCYBDdH3NMJ+8jpg3PG1qV8NV1drJ14qnswfSCdqQIsi3uUvjGhaLo8a27HUb/a6Adf5Z3ZHsiTqTldiegD+FpgvxstZrsYjnjUSRR3ObX1uxo/s0i/qLH+D3O+xx5w6Nj/bXcm+1AwxT2Hzi5Yb4vJ4QilLwan3MhtOzFxWgaW3IRuPT3PbDyr/RUo+Zt2MdwYCZqXt5XT/B1k5Mj4zb+zDgKbHqhduLHZjZZuimbg0K28+KYuZ1lrRXnlkmP4AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:38 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:38 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v3 0/5] Add eDMAv3 support for S32G2/S32G3 SoCs
Date: Thu, 19 Dec 2024 12:24:09 +0200
Message-ID: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:208:55::40) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ebd676-6e57-4130-fad7-08dd201757a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akNmdlRGZEJFYSs3bnI3bUZkajdmajF0MHJFL3ZWRmF5cVo4YklqNnFYV0xp?=
 =?utf-8?B?aVRlOHJFSDZHaEhTSXJXN0V2TDJscUQzbytvVlBIQUdmSGdwanBPN1Rpczd4?=
 =?utf-8?B?K2xqaGxFYWMrTUhmdjZ2dnRhKzF4aVpWY21GUzZDZS92L08vc3k0ZVpDVzh1?=
 =?utf-8?B?Wmt3T3c3Vm9ZWXhHaWUyRDRpQ1V6eHJCT0p1Qkw0Y2NvanYrNERxWHlLRmhO?=
 =?utf-8?B?eUdXY2VCZnUzOE56dEgwVTF0Z3dDWkRsMjk4UWxvODZWL1A2T0JtM1pJc2Vw?=
 =?utf-8?B?T3ZEVnRBbmJkRm4zUXE1RHRGYXZNbUw5VnFHcVhERk4xODc4WG9DS1dDbkl3?=
 =?utf-8?B?bUFFaGNFMVl4b01NUVdRc2haSUN1RXdGM1FVbXZHSG9JU0lyQWJuaTcxMHg5?=
 =?utf-8?B?UThMUm5FQUFpelpybWhkNTNoVEFHb3Q1MGdBTDVoeXZIRTJMcFFBc1ZSK0dl?=
 =?utf-8?B?WVVuQmoyMjRPTDFIQW1WcXBiSnAvTTlML3BZMTc5KzVRbGk2U2psaVNZMUcx?=
 =?utf-8?B?S0E4WTFjTlcxN1hGOG9hZ0Rqb0x5SXErNWhuSmp1aStCRUlhUTZCUlVkOTZs?=
 =?utf-8?B?Q290dDM4anBIVzZ3cEY4ZDJRZE40aWNwdDExZzVjM2Y5TC9JV3dNK2ZUdlVS?=
 =?utf-8?B?YTh5ak1sUFdnR3V5eisvNUU3ZGdUTEFmVE9vZElPTmoxeWpYdU13Q0dUcEo0?=
 =?utf-8?B?ZVlwTVdteTEzNXVvTWc0Vm84U2h0TlMvZVBZZ3dYQzJEYStLKzdBWGdKMU1B?=
 =?utf-8?B?VDVLRHB3ZjJxTTd0TEp3cklHcGJQckEzdUQyVGVLNjlQWkhxNXovZGpVS25O?=
 =?utf-8?B?MkFEd3BJNmZMK0p6RTN3eUJEUzRsVTZ3dWh3dzZEbXZEd3JubWFuWENmbjBq?=
 =?utf-8?B?M3YyT01kVW5qbHlIQ2lLWHlqVU5kK0JrdnNQSVNveWcxdW5OTmFIQ295Yy9N?=
 =?utf-8?B?d0pvZ1lzV2pEaG1aRWlSREZSejk2ejVMREhmZER2bVhSYkQ4VFJLNFRFOFRE?=
 =?utf-8?B?U1VrYTVGcTh1U1lIc1ZUNmpsMXp6eFd0N3g4S2JQV29EVDFBUlNvMVVjNVdp?=
 =?utf-8?B?cXBQNU5nQ3BnRlFFNGxnVDBXaGxxa1VoSUV2UXlhUlJTQkFlZExaV2hYelJ1?=
 =?utf-8?B?YkZFZUdEYU1Fb1l5N056NkN4QnJTUUV5Yit1NGt4L2NsOEd1ak5lakw5dlJ2?=
 =?utf-8?B?RjBzSkhoWlFza0gwNDdzVGFyVUJNcjRSbk5SKzAwZjJ0bWkrVEpUb2VteVFL?=
 =?utf-8?B?aVVJUjVFaEZYQnU1VEpnbmhBTmh2TDhWR2tTZ0Nac0gyVHI5OElyNWt1aUl1?=
 =?utf-8?B?ZHRMT3BFaDhzZlRUT0ZSajlVd213MFQrNjJiaEl5VEJvQmFmRkJLZGxOZVFN?=
 =?utf-8?B?T2ZYdmpCL3RPK09OVEJPNGtIbnE2OFJ1SmtMVlNRWnpZSnBnZk81bnJrZHJ2?=
 =?utf-8?B?Z0RRR3FRekdIT2duWXFlY09KMVV1QUFnUHhuUHJvYkMrTm0ramJ1Y09SWXN1?=
 =?utf-8?B?eGZha3VWYStMNnAvbnp6N1ZEQ0hxd3h0bHJ3YThuODFsdjhhZzNQRm5IbG55?=
 =?utf-8?B?ZlFaeWorWnEydzY2TW03bzFhelVvdXlZOHVrTWVPcG45OTQyZGFjY3VwSGRk?=
 =?utf-8?B?eTVRMlo5UjJkYWgyNTg0RHRLYS95MlB3UUJQSkVoODdtRTVRWDhMUGNQb242?=
 =?utf-8?B?bnQrdTRHR2pKNUlkTGxQSzgxRVZkcXZFZFQyTW9ObVZjM29FbWRFZDVRcDJE?=
 =?utf-8?B?eStpQnZ4TFd5dnhmTmVRY09DUzYraEd1dEFlVm9NWFZ5enBoaU92L0NXSlYw?=
 =?utf-8?B?cDdZTHhWV08zdDNDa243MkNZNE90Y2J2Qys0MDd1WjJWNzlwRFM2OHVGZE1P?=
 =?utf-8?Q?0h0zatuD7L0w9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGdHaC9Jc3NLd2d6YVJ4bzA3UzZlSWViYjB1TGk5dUFDM0loa0xKRVhWQ1l5?=
 =?utf-8?B?ci92ZVkzOUFwZXlLdTEwUDRBNTlVNE5icjN5RFhTTFY2K1l5RS8yMFVwRk00?=
 =?utf-8?B?SkNFRmN0c0tSTEhaenByaS9oK0NFd0RoL29zaHY5WHhWWmdkUXdHV3NXT3lm?=
 =?utf-8?B?QVJYOTIyWGZkM1NvTDRGMlY2L3I1QnRyZEdYMjZLVmtFYXZRWktVR2V2S3RX?=
 =?utf-8?B?QUdKVlU4cTRsUlF3ZDVQU2c5TzcrWFJ3WkphVEhlSE4zYlc4Nkh6eE5JYlhD?=
 =?utf-8?B?L1NMU1pLV2tvcmo3dWN6dERaMndDQlhwSnFZMWN0V004eG91OGdMWFd1MVNN?=
 =?utf-8?B?ZXJUNHBvYkVSWGUzdlpSRk1ONkI5VE9LWDZuR3hGZmJjR1RscEF6SWVHQTJa?=
 =?utf-8?B?R0FNQzNPNC9rdmJXbzM5T3JoM1NpVGhuY2FKcXhWbVUzMkdjcnRBR0dRRGtM?=
 =?utf-8?B?WjZZQjRndnlLTVlFd0FZbXN1b2Zob3U2VURDdktydG1wVHNTWWp5dmwzbTNI?=
 =?utf-8?B?NWdXQ2xielpOdldRUy8yTkExWTkyR1NmNm5nKzdqOEFmSlB1RUdPQTVybm93?=
 =?utf-8?B?Mk45WlBRUDlBK053elVsdmpQbWFFS1FjUTdwdnpmSmlmalNhdWlwVE5uTngx?=
 =?utf-8?B?QkNla3k1QzBZcEZSVEt2Mk5JT1F2Mi8rYTdEVVh1SWRuTElRMkFRQ3U2RUY4?=
 =?utf-8?B?TmhWNXc3UkQyMjU1OWRNN3NUSGFSNzQ4d3pTeHlYT1lBQUUya1BTRnMrcGFZ?=
 =?utf-8?B?Ylh5VmdicUtTNTlSUW1na0RVM213c3JySXJrdlhFdUJqbHZjam12bHRPYUV5?=
 =?utf-8?B?ZHdLeDNndGlYQkhIWXQ5SUg5SUVYNDlSL2Y0ckc3SHVmazJ2dk5KVTVYMkhs?=
 =?utf-8?B?ZjlPOGQ2Qk9pL1ZXVjRWTXVaMm5KUlBWc3BLTmVJcWNWU2hBbXNzNnp2cUk2?=
 =?utf-8?B?R2VMS3lHNXFLTEk3NWx2Qy9RdDBqNUNldG5GZnY4U2h2bGFzdm1OaEE4cTZP?=
 =?utf-8?B?Wk15bnExcU81Ym40Sjl0ZEJWMnQ5eU0xZ25iMFlGaVNTb05OZUhGOHp4WEht?=
 =?utf-8?B?bW5TeVFOQzhValV3V3lkZWdrcllHbHF2aUtYVzN2TGR0dGNGV3NOTUY0dnVH?=
 =?utf-8?B?Rlg1Zmx1dlZJK3JmOU5mMU9ZcURDRldEMHRkYzErNmE3VnoxYnRFSE5WbDBn?=
 =?utf-8?B?aUkwT2huTkcvTE9hRjZUeXZURDZTRlE1QXRsQjZaYVJ6R0pxOWIrMEhTVFhu?=
 =?utf-8?B?OE5OQ2lpNGdTYjFVWnArL3FBNXZvcFBMVUo0RDZJYTQ0amtza01KNytYREtY?=
 =?utf-8?B?VFhZWU5ndEcvcDRKdkgvVVdlenk0UmdiNHROTG5QTm0zSEZMQTNjcS9wV1Nv?=
 =?utf-8?B?VHpNTjlic2haNXVTQVpaQXNUaVR4S29lWXo2L1V4TjUyQmRqMDJLY0pReGUw?=
 =?utf-8?B?a2RUaG9vSmJlK0F3OEYzeWNYSnloUms4R3BYYkhPMGV1cEdhTXVsS2tHdHZ6?=
 =?utf-8?B?b2NSemNWQVlpcjJ4SVhid003Um9XUXIyeml6UW1FS1grcnBPcGJPdjl2N1Ju?=
 =?utf-8?B?ODgweWVrc1VQWXJmODVXY1dRZFk1cGhpU09BTVN3TFJ6UGhLTmUwNlVmajdF?=
 =?utf-8?B?dXIzK3BCMHBKV1Vsbm9JRVhRcmtiaFkwZGpNayt6YXdacHMwSUd4ZkFwekY3?=
 =?utf-8?B?SURGV0szZkZjNk1wZGdpdjU3cW9rZGZnRkNLUXNLZXpBeUlFQ2dCU0JoMG5W?=
 =?utf-8?B?ZXJLUkw4L2hpY25ldTNlZzJXZTBtZkdYL2ZudUQ5S2hVd0Vpd3dMaDN1ZWVG?=
 =?utf-8?B?OE56UmQ2MTZnc3ZGbUU2VEtCb2pqaXVPYzAvelNjMjUxTEV2UHQrWVk1LzBX?=
 =?utf-8?B?ZXBWWE1tY0x1RHdDQysvT1NNc1FwbE15UGtzRVloTHhTR1BndUZER2lxYWJw?=
 =?utf-8?B?N1pmdC9aYkI4a2VxVTdWQkZrUGRudUFJWDZRajhtL2pYSGlubTVaak1TKzJP?=
 =?utf-8?B?QnJHV0s0MFhmWVl3NFJnQkFzN0U5ek8yMnhXdkpWVEFyZEJPWENJeTJGTzNt?=
 =?utf-8?B?SytySXh1ME1yOTNIc2tZeXBMMVM5V0VzWEFzVExjM0p2KzA2U2ZHTkthK1VY?=
 =?utf-8?B?L3lhTWI4Sk42dTZpeXY1L3RVTTQwb3dVRTJ2eWdnTG5mV0VaNjVTbnAxcWFq?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ebd676-6e57-4130-fad7-08dd201757a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:38.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI2a3p9ofEBqLbLVx3zm00UbhLfkh/HGQPPtQDw+PN2gCjlVyzkf/L3NOUrzThes+aBWAlWqWfMnexydxoW42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
integration particularities.

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with 2 DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared between
channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Changes in V3:
- Added changelog.

Changes in V2:
- Added new lines in commit description.
- Added "Reviewed-by" tag where received.
- Removed the three commits:
"dmaengine: fsl-edma: move eDMAv2 related registers to a new structure ’edma2_regs’"
"dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"
"dmaengine: fsl-edma: wait until no hardware request is in progress".
I will send a different patchset for them.

Larisa Grigore (5):
  dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
  dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
    muxbase
  dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
  dmaengine: fsl-edma: add support for S32G based platforms
  dmaengine: fsl-edma: read/write multiple registers in cyclic
    transactions

 .../devicetree/bindings/dma/fsl,edma.yaml     |  34 ++++++
 drivers/dma/fsl-edma-common.c                 |  36 ++++--
 drivers/dma/fsl-edma-common.h                 |   3 +
 drivers/dma/fsl-edma-main.c                   | 115 +++++++++++++++++-
 4 files changed, 173 insertions(+), 15 deletions(-)

-- 
2.47.0


