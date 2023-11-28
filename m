Return-Path: <dmaengine+bounces-273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7D7FB101
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 05:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D31C20A45
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 04:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE56AA9;
	Tue, 28 Nov 2023 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QYj00ehG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B6194;
	Mon, 27 Nov 2023 20:44:29 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AS4EoZB001317;
	Tue, 28 Nov 2023 04:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=to:cc:from:subject:message-id:date:content-type
	:content-transfer-encoding:mime-version; s=PPS06212021; bh=DTzhN
	HhtpK7G1gNLMEZy/Qn03J2paGdfQYKIrk3uwFQ=; b=QYj00ehGT1+FvE7t4xG82
	fksHp9qN5+P06Sh3SEmZLW4icHRmh4b4LCTb6hBTbJoTYMm4IJA/E4dICFnxc9Oy
	HbC/EEEdhWBHf7CurviApGSkcvugbpL/S/VHTjb+1wQrV1BiRkdbxXTfhqTYlWYD
	eNwvFCgfdjizq1qh4D5ubKnYIZCHb47lQpPo7BN9vV5KbDbxxw6bjdfZaXF6YUaZ
	XGiRaNXRJvJjCBCAEUMbSuFpYlBuEBsFmDn2a9+c/re7hKUn7zvVFPgsHnzYXQEL
	OdslCzMJwegqMon2vlbsl0RwatSlT5jFznUNvSkkGVv+uG6RL/iz7e9bYC5Y56Z2
	g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uk7w6j9uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 04:44:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTGg4UNtczGE/ogr+CWHuQC72VGx48TQb+SjwKMjzte//JoLNw9VEWF8yaWcUiSU0eynbeYZjKiv3W7iVxrRfp4TkdonryfUUIpyTq2Ih89vRfna7HvqFIimy/tISSRCRFoJhS8Ne/erv2ipuL7Ok6Jw3TRRbwCGDzIZsTL09bUqwptDNc+gBGJp8jbPisWW0B3dAyap+KA0XZEQmHKMoKBRDLUtQ4zbLyPEGJgmxahc+Kz+jCN4iule1rLzQLhli1Kwc1ueDysMVMhC8hzbfwNiPOPmM2FFprF+UCCmIRK8yywwnljGXN44LquYheBiH10Ro1TPHR9h8eURFfzfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTzhNHhtpK7G1gNLMEZy/Qn03J2paGdfQYKIrk3uwFQ=;
 b=jMo72/qCHtY9/BjriB7QPY4ur1YFNWuDmXFqqCA+l+BqE9Pi1ER8lwgbttQo23pmgX0IAA6IyEhmDmyC261cuoIcwxJEubOSQhJiGHkcI5bIZ97JSQkC3nJ73cxlESPJuJZwkExQNBHr8WqkoD0lSLpvlG+2j5+3WsRY4CB15XeLfs/uG5xeTZJuhL/A4NEsJ1mWuHOXPbX8fi9c5Gw28gEQNo+pq98uzD19oFIqgW7gdLF8IaMOnivkgu2H9Y59tKjusWJjJ36qQ15UZAgQQlw+Fz8fCIfoYS/LnxU5WzDJkfWscR0fbSEGBSly+Pgu87IYsWu7tHStORsL9q1iCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7121.namprd11.prod.outlook.com (2603:10b6:510:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 04:44:06 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 04:44:05 +0000
To: Frank Li <frank.li@nxp.com>, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: wangxiaolei <xiaolei.wang@windriver.com>
Subject: dmaengine: fsl-edma: dmatest timeout
Message-ID: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
Date: Tue, 28 Nov 2023 12:43:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TYAPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::24) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a8770e-6566-4ca7-2967-08dbefcca6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bmMmocO0NOe7wVS5MfetOOOAYSQuOsMiDiJsXCZ2wJ//F0dWNu/1jjMgQNFZc4apXI/AN5+wqGKt/5hP7qsT90C5g9O4mq55F0qf0Fp/+7bsaAnuiNHiza/f8oI/sSdSh9Dg5xluivmJMw7CRg1dIGR13uoP8yc8vPPP7wwdMpy+aCCKHEB+5GUh4C8/tp74yIjjUBjkqgyH56cD/T+K+kYeQWtW1EEHaFZ4tX61PHerQmY5MF1msI1BD0JFSWGoSiYANSY/JXv8xaAbXMcxVlLRaZ/QT0TQDytzeqRAKdPCNjrgdaE8yC/PvST06ZccHcClcYZdNxJQpolJN3c6GYwmGRWE/Gh8UmCWZmXIfIJE9UvBQfTIzOUmTKiOX1h46St/Ns89BfXAt7qPMJa1a3dEpq+vpQ2gRLQkZqEqVyxLiMEcF+Jup2iJawOkj5tDvxWLJkjtYD7ORUmlMvRFtmVZ3x9N/KZyICNi4Zf6foRWuzpWs/eXLVBl2vSb+4ze1jB1IGu50knmCNs6MTCejkX+Yneu4voHYLucoO8SzYrOuVMzcC9cCroIun6P6cDT5u7yltd3ijgLFL6KIS/HXyUsZIV0ceWkFJPENxeo3beTqv/yX1b9g5ynRNIzl9snYdSoi+6p58XQ8azUPrapPGsK2SAPOe6hzQsOucJywnc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(396003)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(4744005)(5660300002)(38100700002)(86362001)(4326008)(8936002)(8676002)(31696002)(41300700001)(31686004)(66476007)(316002)(66946007)(66556008)(2616005)(6506007)(26005)(478600001)(6512007)(6486002)(6666004)(36756003)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djhPcTY0RWNINlpVZm1ocFVXR0RqU1N3YVVaYzhxazc4dndqQzZlMEl5eE1Q?=
 =?utf-8?B?STFPeUNjaUJKOHBONTBzT2pIeVVpZ3pya3BYVjhZSW5kdnVOTTBEczgwQ09J?=
 =?utf-8?B?ZEtYRktVYjJEajA0VWRhRlJGTUZoam9EWFV5Nk81K1E1Y1Fab1h0Zzg2b29V?=
 =?utf-8?B?bXRzWnJPM2twams5WkVuOGRqMG1BK3YwVldtWUJGc0l1cXNiREhid3BDd1Ax?=
 =?utf-8?B?bXd1WWh5UVdsUkErSXR6RXBVUk5uazdxSW55Z1VNbXI3bjdOUFNMNU5pckE5?=
 =?utf-8?B?V3crT0M2bm1tbjVoRlNHcW9xVUZ1MC81SDNJbmFnUHdHNGhYOFhzSFhOYUI0?=
 =?utf-8?B?RHgyQXQvS2VQNlBzSUFuR05iVy9uYjk3NHMxR0s2OWEvc09KWWhKc3pqTkQ1?=
 =?utf-8?B?NlB4YWVsVkhUcmlEZVl3Q3U1bWd3UDZ5ZEtwUmpmakp3ekFxWDFxUmFVUnhF?=
 =?utf-8?B?TERCU3AxeG1pMUw4VitPTVpMa2RRRVVhdkx3bkRRZ28wVHVjRHRrTFQ5RmpU?=
 =?utf-8?B?S0dUUzlDUGREVkN6amMvRmVHYVNYTGNOR052TG9MdVBoZ3lRczdjN2RuYTdx?=
 =?utf-8?B?b1g5TEtwbEp4a3VhdHJ4V0xNcmd6S2ZEVlZCYXMySlRaOFhhMnBNeWk5MDNW?=
 =?utf-8?B?K2M5c3I2NSt0NDR4VWJ5MFgreHJ3aXIveUtUVTVZWjBMRndTclZqeE5OdmVR?=
 =?utf-8?B?Z0FPTEhUY0VtRCtndEI2MEtjZnVRemc4WEcrM1FPZFZhQnp0WFp4c0MwNU5t?=
 =?utf-8?B?WE9nT0NNRnFCVGdrL3g5T0VLOUNaL3ZkN0ZVVTVzTmRGalZ2c0J0UVZhVFZU?=
 =?utf-8?B?T1JBTmlOS0tlRG05K1Z5NkdWRDgzNTRFRXVyV1VmbzUyY1FpTVkyZHhTMGJz?=
 =?utf-8?B?WFp4MCtkcVNIWWtMQS9LZXh1SEpVZVRndHJiMk5pa0tTS2JSOVcxWThqbWFw?=
 =?utf-8?B?RlNUVlYyQ3h6bVJmeTVzSUwxKzR2YTd4aEF1KzZ1LzBQbDhndThmSm1tOWlD?=
 =?utf-8?B?UHJicUY5S2lEaGthWTNHMVlwMnk4YjlRQURpZXVaY215Ykc4K1dwWnc2dlls?=
 =?utf-8?B?WmE1a1dtRDJYa3ZBaWVLUFo2bU5QY3ZqOVhtaVJzWG9zSmZtWGxZakw1ZDha?=
 =?utf-8?B?Zjl3dmFjQ09CWVBBVFNkcE1va0twUTdhUmVoSVlhU25WSFBUVVFweFdDb3ZG?=
 =?utf-8?B?MndxQjltMC8yYUN2amtXNDkyamRaTDk5SkV4WWhCZjA2ODNMVWxnMEw0d01Y?=
 =?utf-8?B?ak9ENG1HQ0o4Q1RmMFl6Um9LVFUzZW15RWlBalcxditUbFduZDBWMU9FbTA1?=
 =?utf-8?B?Sno2TU90NkUvU1lHd1l0Tmo2bTREelgxWDJPalJWZ1FMRzJscVpkYnJVdEsx?=
 =?utf-8?B?YWxOcGtzTjF1N25mWnZNQ2pYcmkvVEM3RG4rU282L2ZabmhGOFdCa2Rad2xa?=
 =?utf-8?B?Z0hMU1Nud1dNdCtETUQ4aHEzSW51Wm1PMnpua1Zjb0Q2VUdZcUhDTktRMFpX?=
 =?utf-8?B?eGw5ejhtSEZyZkxEKzNvNGhoSEc3anlYYnpld3F3S2ozb0ROR0RyZnBVa1Bs?=
 =?utf-8?B?am9qSmdOaW1VR2IxUzIrM1J4SDJUM09HUTNrY3J0YStGcSs0b1dmQmw4VUIy?=
 =?utf-8?B?czBCcXg4UFN4QkNlZURXaXBBTnAxQUhLRDRiaFNKU2tTWFpjTG5ZeHZPdjlx?=
 =?utf-8?B?WlpzOU9udmQvOW8zK1MrNWJrUzN3cmZNL243WXpkdWN4S3FRREx2dEJDUVN0?=
 =?utf-8?B?SjEzL05NVjRqN3ZteWtCN1dlQS9hQ1NNOHV2RVZHL0tzWXhGL1JvZjhSVFpX?=
 =?utf-8?B?R0NCRVVqUXd0enhaOGc2MnoyVEJmUnhwQlZna1dNbG12NXlXekd1a0drdExa?=
 =?utf-8?B?OFprR1IwUllDZWxDU1hNRHNmMlZybEhOMGZ3NXZ4VHFlU1Z3M3FaVWRGTlBR?=
 =?utf-8?B?cmNjdG0vbXNMZmVQZzRicy9IQWUwbEZBYnRuQWJkOHI5dFZUR29hbGFEWkJH?=
 =?utf-8?B?U0Z0aDBVbnJzbzlYcjU2eVVKeTR5VUFvdVJNME42Vjg0ZERkVWhna1N5cndq?=
 =?utf-8?B?YnhWbmlCSWVCL012cElIbzAzYUl6ZURScjEyQ3lqVEJMM2pKMEdlcCszS1dS?=
 =?utf-8?B?NmQ1MmVHc0JyWVp5TWdxWWdFb1VRZ01xaUlqdkZWQWFTQnIxdUVScGx3SkhO?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8770e-6566-4ca7-2967-08dbefcca6cc
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 04:44:05.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b26OIkwLN4O+hzMzpZVV9wgSg1yAU+cqchKmV+Js0h8zB8KBBokn9qBlpQeg3XcSAtre71QDScA2gjAYVqjXclYtKgOKeo6zXrdV4tIlo3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7121
X-Proofpoint-GUID: FY3A4KBv0zkSRV6B2iJTkzYWUdfhOpYN
X-Proofpoint-ORIG-GUID: FY3A4KBv0zkSRV6B2iJTkzYWUdfhOpYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=593
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311280036

Hi

When I executed the following command to do dmatest on the imx8qm platform,

I found that the timeout occurred on the current mainline kernel:


modprobe dmatest run=1 iterations=42


I found that the completion interrupt was not received in 
fsl_edma3_tx_handler().

I didn't find any special configuration from the manual. Can anyone give 
some suggestions?


thanks

xiaolei


