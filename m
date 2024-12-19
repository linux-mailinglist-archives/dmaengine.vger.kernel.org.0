Return-Path: <dmaengine+bounces-4043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36259F7C0B
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 14:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E611660B9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF4224B04;
	Thu, 19 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HqY757ll"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B82236E4;
	Thu, 19 Dec 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734613701; cv=fail; b=cF1fEp4wc0G7FvxpZqwnI1GsJOphNu/cOtT4bjqiD+z+qkt6u/hrwSp+bhdOCzs7G0h0MCoQ7tKNwensfZvjR8qL5GWiDPnH7KbekGEY0WhnwPW7z4U/DrgoobA9pnawr7YuCsOHei9gBbhJc4vNbIpb4n3yh1r40sKJrrXpSaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734613701; c=relaxed/simple;
	bh=ck9r729SRDV93ZDvF34YztgwA+2I4tt/niD1UPpoW/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lg92nKpePag2T73pQ07NODJXtlTQF1hzm8CRb0J7gpO7Hy1523YjNvkdT2lzyQEaTvCfSnF/bggVU6Y8FiK5uT9jWTMPFcmE1/k1fIpmBGVsxg9Fzmw+HkrV0OIC1U5ZFen/17BmE7fgJxjVMIN7jpNyexbPbC4swLZBM2dvtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HqY757ll; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpfhq9BZa7miiBPCt0EM2wfmwiL+RoDX1bVid6lvZefPk+rIA8aZfsNQWCndouBrmyQP7e9OI5gdgOSryOcBHIF4NYQpS/meHv9TN0CyJvRu0QweL5dppn31DcJ38Z5PRgqvcWDbo96Z3762PNPzz6CeKoE1rjz1AVgK/GD4QHtfA4XxbbTePdB4TQGIOxuOJwbg7KzbJoDyLhPvnDKZC5ALYlguqGZISFfiGs4zinvkqDy1jOjVkz3Ho8H8iEtST4DeJY20NYE4VpFW7zc31IwygoZkoGJrqUvT3DFoiXXeiZ5hCo5I3Ygzy5tcu0wfWo9MdnSGasdhvGzHTLUHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf9fIs4+tmWJqZ2Wj8+yoEf75XlkYQ71iygtPWJDzjc=;
 b=nLC69XHf+TknZ6+NjkF9ivcLbqVaOfzq/bRDqb3AaqCfM77IkRthJKfoR5cA6tacJZOIHPKNxFxz/LfUCIEDiDVVYk6evqJBb1beRojPrcl0R9EQ6U6Fs+8+NcszOcxGMLr6GENFWuy5eX1EVJQ5lk2Jm6h6Anf1WkUJytzH2PU6xwfp57pS8ggQT/kSOOeZ0OQ2ZDanbVvste8hFPqMQ6wwC3TZY6c8B9JuID64gAB8bvB5bcp8OgMPQbG2H8w7ozBujYQjgThv52qe0JTTEV2YiilklWLmPH1uCQHxpiMPvVBKnHixkMWT8z2kYFTcuFr8qzmsOKLRwoqwSLHEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf9fIs4+tmWJqZ2Wj8+yoEf75XlkYQ71iygtPWJDzjc=;
 b=HqY757llyk2zcowY6BtymmqBcWdZ4ZjPCiqVcR62aOMM60MAKKR/pq0DgMRBckG2BGmqI2lmvVJy0/wrUtHTGmpINVbrvRJyDEaVJhGc68S1dRR+77/tYGbYCl6xtAJpxb2tmdBm5pdukk3WGc5Y/q0HCoSkXc/uHZFCYhNDnD+NM6flbU22t43SwQVQiu1krn9yDbWSdrWOK1wQudBFMm+2EG2b2saNJgCaPSc2lDyzIE61MdtSn+ie7WzG/JXf2hEz6eBsv8XXnH25wzMFTHmyWb24WiRZ7lt8NDLMpXyw48mOWq5aNf+H6lPk+XSiFTmWxbZESyR0DRaGagOMog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com (2603:10a6:102:26d::9)
 by AS1PR04MB9653.eurprd04.prod.outlook.com (2603:10a6:20b:475::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 13:08:15 +0000
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515]) by PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 13:08:14 +0000
Message-ID: <804ed6c5-0842-47e2-b13c-6f733be5ee19@oss.nxp.com>
Date: Thu, 19 Dec 2024 15:08:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add eDMAv3 support for S32G2/S32G3 SoCs
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::19) To PA4PR04MB9567.eurprd04.prod.outlook.com
 (2603:10a6:102:26d::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9567:EE_|AS1PR04MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 679c3d3a-928e-4b1a-6c22-08dd202e3197
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzV5TTFUQTl2bDhKdGt0UitySWZjWk5nc1NMRndUUFVDT25iN2VteVdUUGc0?=
 =?utf-8?B?WGdmYmlIQkRBQzlzVnhudmZLdjZpMHRZS2tKSjRibTA2ZWs5cmZPS2NzeDZn?=
 =?utf-8?B?b2xzNnBSSklxU0Vab2tLWDc0cllocVJ6Y0lVUG55bjRlTU01V3pzQTJISFFQ?=
 =?utf-8?B?UkhYWWoxS2lqc0p2R2o2MlBqNTlIUVB0VHk0dENHSW9KWnF6MWFFNSs1MHhj?=
 =?utf-8?B?cXBTd1ZwZkdSdUttWVJrYVEybzZPWU9lZjdmN0lEZmIzQjhCNTQrTmNZdHlS?=
 =?utf-8?B?Vmk1eGgrUUZIamxGTng2SWVHbHVJcHhWRWdoVzlaSEJnVWg5TXM1VEpWVE5C?=
 =?utf-8?B?elpYM0t2aTl3bjJvZHhmdEo1dW1jWEtiRUR4bjlvSjZhU2o3bjNKUGhOUTli?=
 =?utf-8?B?MmNHenB5RS8zK0ZnVEFkdjhQczRtNDJxYldJb1AvRnN4YllWNVJNYTlxTWNp?=
 =?utf-8?B?bVBtY3JCQVUxM0ZpckpqZkxRVEwvdzZISW9mSXcxY3BCZms5VFlRWFFEUGkx?=
 =?utf-8?B?aUx2YUM3N0dObkRLeGdoV01qRHI5WmhjcEhlTndBeHJ4S0xRcXJiS1BDOEMv?=
 =?utf-8?B?SGVzN09MS0daL1crQlpHYk11dEFLaGxPU0htV3NyUmJOQUhaOGJYZWQ0VXcx?=
 =?utf-8?B?SkZpWHJWU1d0VEV6VlFoOUl4SFR0UUFVT1ZKMXVsSzlyaGtVSlp2bnNsbS9Y?=
 =?utf-8?B?ak5hUUZ2SFdpZjc2bWpzYzdQQm8rQlBNbkVsTUNjYWtNc1NWWTJXMXJ6WkNw?=
 =?utf-8?B?ZmRHMURQOFFYM2hDcXRTYkYvOVNhdkpBYlduNkJhQVVHZUYzSnpkT25IN1U1?=
 =?utf-8?B?Q0dLcVVnUGVRRXltRDRwZ0xQV2J0WHhXa2JXMnJNdzRRQjVrVk1URmxnbmxi?=
 =?utf-8?B?QTJONzk5MEk1S2hVM1lKbHFpTGpMOVEwVjRkWUVNUFVVVStaY1EyR29FQUdl?=
 =?utf-8?B?dU5xRG5kblJqcUlTU1g3dUlpNTJvTS9TWjQ0MUVUc3ZCT2psc1IzaTN6cmZh?=
 =?utf-8?B?S2JzY0pCVEhDdzROSnJoSFZra25kNjdBbnR4KzdSQ2Y3a1N4bks4RW9NM1dW?=
 =?utf-8?B?WGRuZFU2ZEdoeklnQkZkcThEQnZ1T2ZiWS9USU9ONVlMSWlqWFo5NS9aSWtK?=
 =?utf-8?B?S2xJWk9ldW9sNDdhUlRHZjB3Tk04TmxPVUNVQTdJVitpSE9VOStmSHEvcFVU?=
 =?utf-8?B?WTBncUYrb29JbHZZU0l2anlLMlBZOWdTVzF1Q3Y2Ujl3ell1dkJjN2hrR01E?=
 =?utf-8?B?QUVUTHRwc1JKajJieUlKeTd2cHBKZjRFaUpyUzdUZFBCZWRXeWcycVdmM3dH?=
 =?utf-8?B?NUtUYThjNDFtYTAvR3YxaWRyU2pQS3FCRWMrWmtMdVZBa2lmQjdmbGNHZzNK?=
 =?utf-8?B?M0kxd0ErM3c0c0F3VXVmMmFVU3hOS2lwTld6aU5jRnNDY0tFQlhhRkFEQVJl?=
 =?utf-8?B?M0hxRk5yQmtvMW85RjlranRTQTJUN04yQWJCK1JnM2ZVam4vN1hBem9WTlY0?=
 =?utf-8?B?eG5IcmxDV0IxbmRFd0grZWVOZlRuUFNBT090UXgxNndSUDVHemNXakZMQStW?=
 =?utf-8?B?R3NONnl5NGhRMlV6TUgzSmVyNXo0cVgvTy9VK0VDWTZ0a2ZSc3RMUGR0eC9i?=
 =?utf-8?B?OTFoVGMyTlpLOXYyS1RzSGdyeEp6VGtqRmlnazQvc1dOU3JpV3hVOTBuL0RE?=
 =?utf-8?B?elJFWFUrSi9XRUlHaTZWaTdTWFQ5MXQ1bWYyUVNVTnhLVktLRmxUOUZhaXdi?=
 =?utf-8?B?YUpPZ0FZaXMvMHRGWGYxdTY4MnhDdm15c3RwZVNCQ1Q2VEFwMGozVitCZHVT?=
 =?utf-8?Q?rsLs/4rlYJyU0z11TdCwXSWt6Gm8owDuSeLB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdyWkptZWRNUTRrbmkzNzMvQS8xM1c1VllPbzhBdGhtYlRBRkZJRC9yWFg1?=
 =?utf-8?B?MHQvVTlyZzN5R1ltYlRhOHhVclplc1Z0OFp2MW80REtqS0tqNU5BekwwMFEw?=
 =?utf-8?B?NXQrK3B4aUZ1aERqZmJKSFhGQ05vdk1ybElyTkR1TmV0VDd5TXFPcUVhdm5m?=
 =?utf-8?B?dDV0Q0VnWWU1cWtkMUdKUndYZ3VKMUNXTThBczJ5bG1TeDdjN0tCRXc1TXFZ?=
 =?utf-8?B?a0Q2WDJuQ3d2czVDaCtRcmQvQmU5dkVtcXpDbURXSlM0bThtL3pVeHo3U2Fz?=
 =?utf-8?B?THdmY2tlWGJqdGQwOHlaT3FlUFdxWDJJeVljSTlyVTlVVjVtTHovVXgrWDVv?=
 =?utf-8?B?bHhBN2RlZFp5NkpDVXRadHhjV1h5emdYb3c5bXlYSWJNLzVqRDBHd0hMcTFX?=
 =?utf-8?B?RUxXekM3aklSdHdlREhBeU1KQU1obWMvNGN2Y0djd3dpU2VNNVI1cHNFek1r?=
 =?utf-8?B?bGxLNlRsWExYQTFwMTZNOStkMTZ5V1NSMFE1TDhaTHhLbTUyR3hDaEQvYVc2?=
 =?utf-8?B?QmZxTTlqbDJrMkRsT0N4akVUam9HMGMrcmNKM1FvNEdoWkdPNlRJdm1xMUZW?=
 =?utf-8?B?YjM0OVdIWVFkaXdzZSszRDF6dUd5UjVCdS8rMjh2RjJXUEVOOHpDaHc1UHhs?=
 =?utf-8?B?SGFDQjN4TnR0b2JiaFNxN0M4OW1SSWtvejdpaW53dExJbVQvVURyQ3RQVzhw?=
 =?utf-8?B?cy82eFpKUE9CT1NPbWF2VGpZRHFuT3JON2FSQ3R1Sm0xclh5WU5DNTVHOFhM?=
 =?utf-8?B?eTArUzAxb3dLVHA0L2VUNnRoMERUSDdXYVZlZW82d1pQandlMDh3MWU2bjZW?=
 =?utf-8?B?cnhxRGNnelBLWFRaVS9ZRmN6cDJiZE55KzMrNFVQalZpbktFZWlTNVoxRTZk?=
 =?utf-8?B?NzR3aURDVWxDUUQzSVI5NGlPZXdqVFRJMXhVTHJrYmZjTEJHd29SMHk3TWVu?=
 =?utf-8?B?UVI1YllNdTdTSkdaTlAxZXRta3p3SnNWME5kdHk4OXdwc2hSRXFTRVNmVHJW?=
 =?utf-8?B?akhwZUE5QUpsbW5JeXhmVUJpRnc1bWJWcFd2Vms1TmlCeFVGOGVMRk9xUXd4?=
 =?utf-8?B?UThtREhyd0VJMmVaK001alVWQXV5TnZWeVIxZVJQbjJVVE4vN0FKUmlkNHFh?=
 =?utf-8?B?NW1GWExGWFE0bzBrbmNTaXk5TWdlM2hsYzRycm5Da09LSzRGSnFsSHF5R2Rw?=
 =?utf-8?B?S3lhL0dzTXdsZzcrSHhEU0dHaXR3Q1dtN0RHWWFHMHV2dnBGNG1tdFNuU0ha?=
 =?utf-8?B?SGxwbHgvL3pYTnFCMk85S0RyU2xlKzRxd3hpeXQ4NVdyZUJwYjVVTGxFbXB3?=
 =?utf-8?B?bG5jY2VPcXRMRW9MNzFtbnRQN0RrM3pmNlNYV0s4SVRSU1A2RmRKQmRxU0hS?=
 =?utf-8?B?dDM0d1hxaGI5NjhKSTNhM3ZJN09hSk1RZlkvM3VEKyttNDQ5ZE9sSjc0OGIz?=
 =?utf-8?B?NUQvTE54V3FBS3lXaGlaUGZadm0ydW5hZGNUYkhmdmFsWXIzalZCV014TVNS?=
 =?utf-8?B?R0VJTG02TDhkWDdOSEtzaWVCTWo3Rk5PRU0vVjJLc01ST0Fmby94Q3MvWklK?=
 =?utf-8?B?bFM1NzJXRnpZZHo2b0x1SzJVQnNEMEM5cmFzVDZNdC9LR3JXN0ZNZ3RMSnVV?=
 =?utf-8?B?ZWdFTGFvalM2M1gvc05rbXpVT29hZlduN1ZTRExvSVRERGNvWTRBSFJhUSs0?=
 =?utf-8?B?ZndaNDk1NzU2amg1Z283U0xDa1MySEQyM3EraFBQUmkzNkl4UjVud1lRUnh6?=
 =?utf-8?B?R3NPdzJCQU80encwdWcxYlhuTkNGY3llQ2F0aWlmTkNHbWdYNDFlTis1WTBt?=
 =?utf-8?B?K2pnc2ZwMlEvWGlleXJXcXc3Q1cwNHdrYlMrOXluNkwrcUJqd2J3NlZlV28y?=
 =?utf-8?B?OXRNVGpVOVVjVUU3c21TcWR5Q05xSEZpMFgzY2JaUlQyblJlRnZwSzhsTHFB?=
 =?utf-8?B?c2ttTW9GMVNyOHViWVhXbzRPNnZJTHNUcm5qM214YmZ2U1h0b1F0TFlscE1Z?=
 =?utf-8?B?dVA3RFY4S2tsOFhVRzlodk90bUQ0ajlrdFZYTmJXSkloL2JTR0pXdkRmODFW?=
 =?utf-8?B?RTNYTGMvaGRxdUZaK0Q3SjFYU0xRUnBaQjRKY2tQeGZhbmozSEo2RHBvN3Fp?=
 =?utf-8?B?dkE5MWhMMDRtelZKQjloWFVOQVRrcUwyV3FKOEQzdFN3U2x0R3pNNWRCQUU0?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679c3d3a-928e-4b1a-6c22-08dd202e3197
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:08:14.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO9fYH+EheNK1h3CMYvl8WN5GWRE76XsuqP508YO9cTtdXiJCj3dKzSotKnVkkVCGWyaRl3tvHiCkQ2y+9oJjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9653

On 12/19/2024 11:18 AM, Larisa Grigore wrote:

Please disregard V2. V3 was sent with the changelog added for review.

Best regards,
Larisa

> S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
> integration particularities.
> 
> S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
> them integrated with 2 DMAMUX blocks.
> Another particularity of these SoCs is that the interrupts are shared between
> channels as follows:
> - DMA Channels 0-15 share the 'tx-0-15' interrupt
> - DMA Channels 16-31 share the 'tx-16-31' interrupt
> - all channels share the 'err' interrupt
> 
> Larisa Grigore (6):
>    dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
>    dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
>      muxbase
>    dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
>    dmaengine: fsl-edma: add support for S32G based platforms
>    dmaengine: fsl-edma: read/write multiple registers in cyclic
>      transactions
>    upstream: add eDMAv3 support for S32G2/S32G3 SoCs
> 
>   .../devicetree/bindings/dma/fsl,edma.yaml     |  34 +++
>   drivers/dma/fsl-edma-common.c                 |  36 +++-
>   drivers/dma/fsl-edma-common.h                 |   3 +
>   drivers/dma/fsl-edma-main.c                   | 115 +++++++++-
>   outgoing/description                          |  12 ++
>   outgoing/v2-0000-cover-letter.patch           |  42 ++++
>   ...-edma-select-of_dma_xlate-based-on-t.patch |  39 ++++
>   ...-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch |  35 +++
>   ...-edma-move-eDMAv2-related-registers-.patch | 199 +++++++++++++++++
>   ...-edma-add-eDMAv3-registers-to-edma_r.patch | 104 +++++++++
>   ...ma-fsl-edma-add-nxp-s32g2-edma-compa.patch |  83 ++++++++
>   ...-edma-add-support-for-S32G-based-pla.patch | 200 ++++++++++++++++++
>   ...-edma-wait-until-no-hardware-request.patch |  68 ++++++
>   ...-edma-read-write-multiple-registers-.patch |  90 ++++++++
>   14 files changed, 1045 insertions(+), 15 deletions(-)
>   create mode 100644 outgoing/description
>   create mode 100644 outgoing/v2-0000-cover-letter.patch
>   create mode 100644 outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch
>   create mode 100644 outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch
>   create mode 100644 outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch
>   create mode 100644 outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch
>   create mode 100644 outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch
>   create mode 100644 outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch
>   create mode 100644 outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch
>   create mode 100644 outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch
> 


