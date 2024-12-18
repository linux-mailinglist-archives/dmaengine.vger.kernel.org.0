Return-Path: <dmaengine+bounces-4023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728349F6A39
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A3C16C735
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826361F0E5C;
	Wed, 18 Dec 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lscLvVhJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF01DFD9C;
	Wed, 18 Dec 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536395; cv=fail; b=u0IiW15O3CSEdhLvndRpH6nk+GeQk2IkLsbMIF/7MMp0S89HjusBvt7AEOYmxDa/QsJjEA+codvTh+UCQMqUQQPjLBOuXZOr3xOgcnMUL8tjBbgtLK62JYPoFYi1EdTFGDF8y8PHRosKmNWQ6vyFwPufN8WBA2aymw2n2vnPyuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536395; c=relaxed/simple;
	bh=zOHl2+VVrbQWQWpXO/vMCuqJ2Rh6yfY9cS4SLSu1Od8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klvDX8fLQcb+qnVW8QLMuIUAPNg9vvh3I8t94J35QXjhcQOLpgEH3NNggNoSxOMK9c5sG3UK04OMOt3mmmiKpShLs3z3yUgyK7uZH7YNoI7hFGL5x2UWF+cRuOoO4ikmIgsgWSzTVW4OtNsZDzwOhxUrTvhS+RMgoFVxkZdJ6dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lscLvVhJ; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsHKtJzpLvQRrue0KlAVufO8v2eWDcUR+hEZrUtf1jP9PYy9rNVrN4vQJ2T7ylxCYjZ8if40klQUAt8xKxGFmY0XQwR8fTaa6eTUBlkgAu/aqs8pgILlb9gzInGM1BO6xGBD1Y2kbdMyP9xctiyvdITEHrOt1CtqUAfeQIJUKpuQYarDOurYY6/a5WLmaGatlfG0NC0JCRjNJTFHc/iwhu++n9fApAw1alNyfVLLjVZ3KjBsyh7igf+KauEUpuQE4PqdqzLEbE28rSKPqFpm0U4Qy72KXMz7k67k5BG5axrx6ee5kBnaqcRiwInAht00FGpG7PgUX+1a5hydzpoEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT4aY/tdZRXm4+XEG9dOzYUXpQMPCfEX8SEUP11o7UM=;
 b=ojehyW9lzm6uc8tAoBmEOGHt97nnRV0P/KTje+0fYUinuJZJf1i5oPXHArFe14IgDLACvXaDJjuqUAwMH76UpiA9hEsdi7AynRyXEF3K1yhM/2Vj159FIPqgbSVbEet49MNpgOH/W3RkWMbDDWhhySjol9sDLANWgDcdUwm3U6GJKDWiv8XYjg6ABayoGyW/1/6RZ/OKPVT3s1lVGG+rC2Q4dRkOU0qWEAk8/7IpJxhGynAidK5f49yxXospj3EOja664qxArhwJd2qBt72TucJOH4T6I/NlcO+dr8/7Kfh9criD/8NTGxouoqE88lkvY0h2fO3rhseWZI+VQmaBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT4aY/tdZRXm4+XEG9dOzYUXpQMPCfEX8SEUP11o7UM=;
 b=lscLvVhJvxWmnzxAJ/4gamt1e3SlxbvaX1vE9TtJ6D9z/WS2F06qMRzmwzv6AFn9IZjh+Yw+hepi5//lwaY2F71zJIEXEqUoQ184OkdWeJ7YJTWaDWgI7c+6UP0i6QtxWZIf8Z1dPkzICJzkJKjRzaESBWgjlpBr6KG5SJ7JzQcu8yazf4Ne5mi3ppx+78M+NJxmeIy9XCVqm6+xR8hAJJwvbAMrh/GkBLx+lAHpiCb30zDk7IA5QtLYLLdDRkw23i67Yx1xJEN0HcBOJJQBz3rzd4S58Tff4YvFTn0APv8eVqyOkF4hCQq1U2NsFJ61z5A2bDHvBcamOcN3pIValg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 15:39:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 15:39:50 +0000
Date: Wed, 18 Dec 2024 10:39:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request
 is in progress
Message-ID: <Z2LsvNHKVMAlDsG5@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
 <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
 <d5badfcf-58d7-49d4-8a5a-d31de498f015@oss.nxp.com>
 <2e0e1fe3-af5e-4416-8b34-3fecb923b481@kernel.org>
 <458f8940-4451-4dbd-bd50-75a43e4248d3@oss.nxp.com>
 <60b8eef7-e946-4e86-9116-46fadbafb53d@kernel.org>
 <d96a7dfc-af73-4296-bc26-4f1ccae8f7d7@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96a7dfc-af73-4296-bc26-4f1ccae8f7d7@oss.nxp.com>
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 032a6f1c-47d5-4a26-11c9-08dd1f7a3569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFNMaWxPNUxhNEtXVHNWQ1lGK2wwU2dCQXpucjBFb3lmd3FNL1VyOUVuUytE?=
 =?utf-8?B?WVA1NUhWVmN1MGpOTmF3SGFxS0ZGbU1KMGNHeU5ocDdPbWhEL0xvZXdVYzJt?=
 =?utf-8?B?UkhXdWpWM0NVcTMrUFkxU3M4YUlQWDVuTXdneVNrbXFlYUxsSVYvbjJuS0gy?=
 =?utf-8?B?cUlLN2ZnRGNhZk5ZOTZhYTczdE56MzFsMGhpNTUvQW5lUldJREJqVC9Gekp6?=
 =?utf-8?B?azJJMXpPaGpxZWNmcmtiTldVWGx0UnV5SEhqTCtOTnVDSitoWFRoQXpja0kr?=
 =?utf-8?B?SlZWeTVEVWRkQmx4RlJWV282RC9lbGtVYk1hMzFzNHNLWVEvQUNRcG45b3kv?=
 =?utf-8?B?RnpjaDFweHJFRFlVUVNqRE9mbGNnRmN1cUtxeXFHdldnVngzTnd2OVhCMnhD?=
 =?utf-8?B?WkgyLytCbE1yeEdTeTllWGFTL1JmeXVnOTNhOS9XM2R0NWMxMFNyMW9oTjBE?=
 =?utf-8?B?bnBjTTA3MndyQ2FIV2JWYWE3N0NINnpKWXNJaHdQbWNld3FyTGZKMGszaTVl?=
 =?utf-8?B?YWdNaHBOYUpjcVA1RzFIcmVheXdEMmVjZ0dBR1ltQUVFZmRvK2lnaFVNeGx1?=
 =?utf-8?B?WnR4NmxFZFdscG5MUnQzS3RWb3M0cnBrYm1pY0NaNmVySkIyYk96ZnVCZ3B2?=
 =?utf-8?B?QXZJWmhqTzhFSnVIQUpwNTNSWGY1bGVqNUxNNjg2bnBGSDVaamY5RzVpcHhS?=
 =?utf-8?B?eUVoaGtKUUFoYmppMVVUZTVYTXNFUEtja3JVRHlsaXI5OWlLYkFoUTlhWGpB?=
 =?utf-8?B?TEwvQ3ZmOS9Tcm9lKzQ4bW0ycmxNMUZFektncjltQ3dKam1xMmwzUmhqOXIw?=
 =?utf-8?B?KzRQVDBvRHZoYUk3alNNWnFaaW0yVHpERVZtNm1RZGlGbXhSUHNucjVZcVhk?=
 =?utf-8?B?Q1hCNnVtejFaTXJLWjhQcUdmQmczK2tka1NQVkVtK2FmVFpsQ2dNWjkxd1NS?=
 =?utf-8?B?TlpROVBsRkJWMGUxSHFTT3dzSzRua3hQZGI3MTQweThIQ3VLcUtBSXdjUHBa?=
 =?utf-8?B?NXE0SHVNK1VNSko5dUtlV2lQNzAweFdKTG0yNDQzQ0lsK1lsTTRjdnd6SjMw?=
 =?utf-8?B?Y0ZlcEx3cG1SYS9JMDhxb29ISzVpbENkMlhQc0tpZ1B2NlR1MU1qYWo3SCtR?=
 =?utf-8?B?alg4K2hEa00vNXdlTUlhc2ZOZFU2dFppN1NVQTQwZnRoVEpUWmgvSXE1T3Bs?=
 =?utf-8?B?MXZLVFlCbHlWOE5EeTBpQy92QWh2SHN0Z09RU1pla3JZNzBha2d6L1dzRUEy?=
 =?utf-8?B?Qkl2NzFpaE1qeUNEb1dnSDQ3QXJNdlZvQ1RtR0lRSTIxV2dsZHpvNEZrODhP?=
 =?utf-8?B?WVYvWXRYWHN1K1pjbHFJNDViZWl3ZHBSMFlSdHNtM2JaQW1nTzJsbE4rUS9l?=
 =?utf-8?B?MjRPTjZKMXltMmwvMU9KYlNYbEhuNzlmaTFNN2h5T2RQclcraHJ6czJNN3do?=
 =?utf-8?B?bzNOY0xWN2pKd1U5TVhnZzFBQkpmNVZJbjR3bUFDTlFmV01xNk9rWnNtOW5Y?=
 =?utf-8?B?RHRLRlREbys2Ym1CZWZacERNRXl0NzFTam9sMkxCTUlNUWFBbSthcllkM1lK?=
 =?utf-8?B?bk9VbEJ2b3l0RmFBR0RJTXRkSFE1ZFdxOHEvdTMwZ0JRWFArR0hLK3FpY0xG?=
 =?utf-8?B?cjRBWXRCV2g3LzR3OEg0dVAralMzTXoyc2VzbGZNb2dOR1lHcGYvZUt3VThF?=
 =?utf-8?B?NEF6Q0ljbFlQbStpOW84VlViZHdWNExIQWl6dUpRekxpV21DK1BMbHI0OTFk?=
 =?utf-8?B?L3Jzc2dYR0hmQmhYR0dIOGtHdG9hRkZheUhVcjM5N0FwSit6Y2FyNmZ5VUp0?=
 =?utf-8?B?TmpxNVZreXQzV3BZM0tQNFZSRFM2azd6OW9nZEdGU3Qrd1B3SmJHR2gwdldV?=
 =?utf-8?B?S0RiS01KTEJBQkpIZGJOdVl6QUg4QTVSQ2d1YVVWbGd0ck5NcFhLUFp3UDY5?=
 =?utf-8?Q?I8pNTCcOVzzXXiGKbiYbiI8x5yfApYTI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZETlJKOE53WEJDOU5zRVhtblMzbWxTOVRQUkpSKzF6aEVNamNxb1FBNGNM?=
 =?utf-8?B?Zk9KT2RpVU9Qeis0N1E2Wmt3K3J1bmV6R0ozeUNkSnprZXdiZitGWE5wQjZZ?=
 =?utf-8?B?NWdCbUtwbmNsaVB3SzVhalQraE51MnFsMjVKb0lOdnZ3cFJlMmpnNVE5ekxi?=
 =?utf-8?B?T1lVeGo5MlBqU1QzTWxwK2VxMHFWb21naHJxbXF4Z2xDL2hrTUJvVGlDR3VN?=
 =?utf-8?B?cFcwZjZDYUpIczY0Y1lmQ2d4c3Y2QkR4TVUraEdrZDNKU0tFSGExbGJXdjky?=
 =?utf-8?B?d2ZYUFRFNFVscHQzUWxKL294VC9rR0Jzb21zWG93VHliSkcrVXNOYTBFMWRr?=
 =?utf-8?B?dThJNjl1RHFjQ2ZIZ3BaQnhuSTVXenF2Z2VSWVJzclo5UUp6ZklGcDJJWWFq?=
 =?utf-8?B?SzljdjhLN05HRWZzOW1BdmU4cStkQTFDeGFvT0RHMTA3enJOWk9FczRkRTVM?=
 =?utf-8?B?c0tZeUMwSmtsVHBJRERVa3FKMnZHcEd0ZzlUT292dkFRNVZQWFRad1hndFlH?=
 =?utf-8?B?eFNtUTVMZFBDR09Fc2lEZFM4QjVSN3hDdzJGMjVCY3Z2VVJDMXkyUkRldXBR?=
 =?utf-8?B?Yzd6SGVBcm1xOEFORHVFNkErWmh4cEdSMkdBRkw0SjFZKy83VitGRm5qSnFW?=
 =?utf-8?B?V095bHBzVE9sSjl4dWFGU29LTmlmSG5hNXJrUzQ1NTYyeFdmRkdEUENRRENq?=
 =?utf-8?B?dWQ5ZDA4Z0V0WjY3MlhYWDAzWlJQN1Yvb1ZKZ2VHZGZsai9PbitxVGI5emVU?=
 =?utf-8?B?QmZENTVFMXFsTVVYeEpkSWloUkxBWi9PQUxYTTkrRDMxMkpuYTBBTUlqc0JL?=
 =?utf-8?B?SFpHN2tuUmZRNVI0dXNQeklLRDdXWVhsS3lNWk1RL3crcDlPczBBcm1DSHht?=
 =?utf-8?B?Z3BZb3NkSEZ0enJKWVp0RWIvZ0NrNU9iNXVTM0RQd3B1cndBb2paeHVrQWM2?=
 =?utf-8?B?T0hITzFMb1pWVm1ldlBtajBmSE5DOFNrcFpXdTBEQTR5MHNqUnFBcUUwaDNF?=
 =?utf-8?B?L01vMUN6Y05zVHJTQjliYW9TYzVsclNINmhxL3RBcy83S3k3dXhEMXJkbStH?=
 =?utf-8?B?Z1ZtWVZQRXU3T2taKzAwSVlRR2k4UExKMHVCRHZtYXo2Z0dRV2g0NXBGOHhp?=
 =?utf-8?B?QlJOM2NzOTN6d0J0Vi9FVmhIM1hwZXlQYjcwVUcrL2ZUY1lmek00cmpyL3Zh?=
 =?utf-8?B?WmRBQ00zMFpuYlI1Nk9IR2xobnpEd2Robk5rVFh0SGFQb1hZTnRxYXZjbFY1?=
 =?utf-8?B?SXcvTmNGcnVFOG05OFZxdGttb3QzbHBnSTEzQ3B2OGVES25oMlkyZVlyMHMr?=
 =?utf-8?B?b01ac252Z1E4N3ZIZThWZUZzMkRzdlZQUDZ1aTZDWlJhbVhRcUZEUDBnNExk?=
 =?utf-8?B?Z0RRMGdueDdTNGwvYkNrQmRYQU1WVmFRVFlUREhQOTBSSWEvU2RGSXFjMmxk?=
 =?utf-8?B?WExuV202NlNYK2ZLSHNEcnl1ZlBaRFRuTFZtclV6WDZReUw2ekd4Wnh2QnV1?=
 =?utf-8?B?cURMRSs1Ry9vMC9oSWY2VzgvejZYamxxZ3ppenFSNk56WTZnS1lwS0Z6L1hQ?=
 =?utf-8?B?aUxKWEgxbVY2RGpMRWlVRWtCOWFFSWJ4bEQyWHNzaHY2bUxyZHFuK0lUaGlm?=
 =?utf-8?B?eFRlQitDRzRXREVCTHJDSnljZlpaelkwZHpZWTdDb3RvNnpTOU9DOGxBcU0x?=
 =?utf-8?B?OHhTaUJWamtyOGtxTU1KZ1EzTGQ3bHpiclc5MjNFaU5QVDBmNVZyNkcweDZY?=
 =?utf-8?B?UC85aGpOR2pnamdTbGNBb0pIWnArelJMTkJEcHNZNzR3QXZxMXpac3JCYmVq?=
 =?utf-8?B?R2tFM2lreEpSd0V6QitETXk2d2h6bEFFcDcxSDR0KzlWTlh4cjVMSmdXOEhY?=
 =?utf-8?B?d2lWMEZoc2szc3dkQy9FNXlPQWVjN0o3RFpzWVNMdGMraldCRHUwb1JUemx6?=
 =?utf-8?B?V1BMOXdyVXZzSEM3SWdsbG5ueDhxQzZiS3JWMThqZ0x6K2lWRUxQNktOaFdq?=
 =?utf-8?B?WTgzWDk4cXUzZVBSSEVQWkZ0NkM0VFROVlBiQ0E1QXhaUTRGTFpHaGxnd3Nq?=
 =?utf-8?B?YkFseFJPQ3RRVGdteDdQNFE3d1Vnd2l5U092M1pxMTZSUVZhVW9SRFBqbzlI?=
 =?utf-8?Q?7bFk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032a6f1c-47d5-4a26-11c9-08dd1f7a3569
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:39:50.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9beOQk5aUSG8Tt6/6Du0yV1GWumMjyBNiGrT7p8rfb9THms7sZQ5NpsJg+63AFOz7zCecQFxzNu90lhLAJvRWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

On Wed, Dec 18, 2024 at 03:38:38PM +0200, Larisa Ileana Grigore wrote:
> On 12/18/2024 3:32 PM, Krzysztof Kozlowski wrote:
> > On 18/12/2024 14:24, Larisa Ileana Grigore wrote:
> > > > >
> > > > > Thank you for you review Krzysztof! Indeed, this commit should be moved
> > > > > right after "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"
> > > >
> > > > I don't understand this. Are you saying you introduce bug in one patch
> > > > and fix in other? Why this cannot be separate patchset?
> > >
> > > The bug was introduced by 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate
> > > v3 support"), commit which is already upstream.
> > >
> > > In the proposed fix, a channel is disabled after checking the HRS
> > > register which is a eDMAv3 specific register.
> > >
> > > In the upstream implementation, "struct edma_regs" is created based on
> > > the eDMAv2 register layout [1] which is different compared to the eDMAv3
> > > register layout.
> > > The "hrs" field, which is used to access the HRS register, was
> > > introduced in one of the patches from this set [2].
> > > So, this fix depends on two other commits:
> > > "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"  [2]
> > > "dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
> > > ’edma2_regs’" [3]
> >
> > OK, this explains the problem. Your fix cannot depend on other patches.
>
> Should I remove the "Fixes" tag in this case?

You should move these fixes patch to first patch in this serise! So greg
can backport these fixes patches to old kernel easily.

Frank

>
> >
> > Best regards,
> > Krzysztof
>
> Regards,
> Larisa

