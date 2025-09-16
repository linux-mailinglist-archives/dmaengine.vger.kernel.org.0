Return-Path: <dmaengine+bounces-6531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0FB5946E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD2B189ACCC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C32C031B;
	Tue, 16 Sep 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvFzUsZ5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XEafVtws"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840622C0F63;
	Tue, 16 Sep 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020170; cv=fail; b=a23bPmI+taFo9MecqJdv0FQV+Ghox1PpUk2k1anoZnU55qS5iNBJAPfqbbgQMJo27ozmBkWvZ/S8SQNqoi7siaSNSWHz5kEx/raswT4VkXN5Dunfu1lkZz1y4gOxsMRbW4W3waCK9o7hcJPGsP5aarRL01gCOCK9EWcYxDmAFSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020170; c=relaxed/simple;
	bh=BQdFO0zD9153toPeUSDi2tKu6whvNkYt9AftSs5SEqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9VHvBQU3Mj6/5eBhR6oqqvWEYjsCPpzSwnQLWzYUgFBfIeWzSscka0Dnxg0dLjjnT1BZBTWAGEl+It9XIKisaZMx62yNbjtCk36eRhY7dLiijMVtt8XYLFrFrmjOqCXrStDTivZ+bzbDoPuju2oZR6wTb5sZXcu7VvlSn/CgQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvFzUsZ5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XEafVtws; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1foGq004341;
	Tue, 16 Sep 2025 10:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ETIkfwIP48SGA4ZBLvfg7d5GSQW2mWTXKj+uS4k5Lrk=; b=
	CvFzUsZ5n+ZalCFgy7Mvd7eTP9R59Q+UjfiSvY49wZBzusbepMVJyoYRsvIvM/d9
	6NItV4r1re4D6ta+cJEsxWpjJPrZEX1YWBdMUKQKgkmjvsCuSmL6FNIN04wk2z/9
	cyFojeKo1fuOFbG2IkMyrdRnDaq38G2vFn6Bd19gghgMQnGLNo8z19qqLn+27pqp
	5rCvKMA7007CNfHZFPpmgCttAqJB+i/fyMKR17fPTVWWnet++TFLuimAlNS9/RnR
	JF92B7ZlpTWd+oEYyCRs793zLHV90Z6bRZcJI1/ftqkgTC//pKT7CPZb0TBrKn4m
	puT1TvM9/1jNQ6y86f0v0A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fmbdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:56:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9B08l036905;
	Tue, 16 Sep 2025 10:55:59 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2c86aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6rusCpTvgumOkeTyIcyOtmO4YzqnMbtz+WvT9SuFX3++sL516Wt5BJHZA10j5i3ixlVODwCKFfCXnxrzulatEy/3o7ay6L0Mmdgen0U4rEozmlaZyd6N4zxkCRk31A4TPGnex4yp5EL1XnT3oVjnex0a8pj6FPUeW3gJIhmnnYQWXfsQEPcEk+xh4Oph6+YSrGPUibmG94W08wCp/hvh3ifO8ea0FEiHzti9kwFVWze5spfp/gENaOBpXG/yt4FuOS1eVPVu3WbauT/7rD8+CKXMt8Z+CM6Vt2jM1+2iH5YLwlr/4k1kaffzSGF05jqcIkFrVKUXBSUUwDy+oVLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETIkfwIP48SGA4ZBLvfg7d5GSQW2mWTXKj+uS4k5Lrk=;
 b=aLlAeJSK+rhlfE9uZwW5yANOURZDEqNx/Qln8CZZ3m9+VYEsmsyliTlgyNEqFvthVenYPjT6n9IiqpN86+b/qKqyB+KnqGVYh/MLpORytnp5sqRTuCVvb5Tf6AzQzt7sxA7zrj5+tNPPGNPa+SNjkwMGiRDq/GlMnuc94UnwWK+W+LRPt5MFIfeEH5vw52lG77ZGq6CAZS/g5dUDlCV1mdwjhRnatTvNilxue9HTR9/jPBq9paGqOh9Af0dUHTosVg7fotIQkyAT6fn5U4Zn0D5/+wCL1TDmy3ZSNbPQM9Y74a7axTvdgjhI7Qr3am+R1hNuByOONJDQ7YFfYclz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETIkfwIP48SGA4ZBLvfg7d5GSQW2mWTXKj+uS4k5Lrk=;
 b=XEafVtwsD8ryvO90L/L1hc/NOBdMRPqK6glsfgo/0mRqPLSsaNHDz5ZRr3lQzRBF6al3JlD3pyyEMeM9ul7/zsXWx87lhgarl2awtc0ZGACq5k3GZFTpGmUjEhCJ9IVG0XInwcUNWMGnxigo+h02D6VSH10p7m7kShY4/ZWXaYI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8518.namprd10.prod.outlook.com (2603:10b6:208:56a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 10:55:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 10:55:57 +0000
Message-ID: <17dbecb3-6261-4df4-a2ee-e55a398c732b@oracle.com>
Date: Tue, 16 Sep 2025 16:25:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB
 Endpoint Support
To: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
        mani@kernel.org, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com
References: <20250916104320.9473-1-devendra.verma@amd.com>
 <20250916104320.9473-2-devendra.verma@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250916104320.9473-2-devendra.verma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc6298b-21db-4bd9-d956-08ddf50f9d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVhSSUZia1UzU00reGZEVUxLV1laejZMRy83ZHJtTWJWSTl0QlpJOUI5aG8x?=
 =?utf-8?B?V3JnekdySUR5R245aGZOWXQ0WXRoNk1TUWdFeENiMmhFZ0dWU3FDeUZ0NWcx?=
 =?utf-8?B?dFRvK1JlU21aK2xjRkFIVXVraFVucFdtSDhrelVZYXVKOEZQSkxSeWt2aTJC?=
 =?utf-8?B?SW55ZDJLMy83YXJtVTAvQkNIZEpmUExpN0xNckMzWEw4MDczbGxzc010S0lV?=
 =?utf-8?B?NTRHNE9GcGRwNGxLakpvRzFZMTRUVGdmRHk5Ymp3TnBZdzFhcTNlbkJXQktT?=
 =?utf-8?B?aEZsTys5N1RtQmlHbm5hbUg2NVIyaTZWOFplQWdLMGU0aktDVTI2VGhNN2Vp?=
 =?utf-8?B?MiszNSsrR1pITHBXRWZXY0dtN0g1LzJmOEFrRk9XbjZxc1pkQWxUV3l1Zm15?=
 =?utf-8?B?Mk5PMG1kOEFLNVdWb3E1RndiNDhYVklpcFpOWlVjSC9HbVZRd1BjZFEvUTVv?=
 =?utf-8?B?TW9qQk5MbXJ3T1ZqbjJDbDVKM0FYZVpJbDdONHFSRzFoUGQvMXFRd09CNDAw?=
 =?utf-8?B?d1FhU3lPQ1VoQnJoUm1LWW9iRC9iblBvakJiL2ptYktsS1U0bEcvMkRrbmZo?=
 =?utf-8?B?TWZxUW9xaENGVDJGMDJXck9nT3Q5WXB4bGp5c2haYklndjJLeXhvODg2Nmt3?=
 =?utf-8?B?TFp1aHcrOWRJWUtsQWRQNW5LaXNvNnZLbWZqY3B3ZGNXN2YyMFlaaWRHSjZN?=
 =?utf-8?B?Q3AzRXJrQmlvN2hIR2dzRGxtQVdScGIyT2V3aWNCWVBXT0ZDdXJkTTRmV2xX?=
 =?utf-8?B?eHNTQVQwQVAzYmdSeHZHdElQcElzL2RrSFNsV201Q2lqdDJrNERJbktyOFBk?=
 =?utf-8?B?bmNiNSt2aDN0OCs1MVcwRUhmemxmd0tZRERsT05GUUpwWkMyVFRBWU5VOW9z?=
 =?utf-8?B?R1h1NEwvUWdEa05QQXBtSEpQQm1uc1FGd1NOR2x4K1VlYnpJcXpHMFp2NVY0?=
 =?utf-8?B?QkdwZWtKMzVTVTRhMG9mWENjS1BzQjhscjZRcEtEbE83Tkp3MlhuazJTUFZv?=
 =?utf-8?B?eEFidFhwNFg2QlgwcHFhbFptSTBCVStPU242K2NpZ2pxQ1UyMTRldDNzbUgv?=
 =?utf-8?B?eFdNb3hHRUZCUWN6NFo0Q0lOV1lhRmhxQzJpaHdaTW1NWjhIMHlHOXdLb0gr?=
 =?utf-8?B?a1lJMXBzYllqQjUyd010Sm1HTlNEMHpoSFFLZlpiYmUzUjdoaVkvbytUWEly?=
 =?utf-8?B?T2xvMk9RZ1BTRlZaQWM4QUpuWXhiY1ZFT2dKODJvVys3YUl3d0J0Y04rNEJH?=
 =?utf-8?B?dWhFKzhwdDBSOXJGa3RDc2VxdnU3UFNuMVBVcEcvTlVucXoxdVVWc3pURmo1?=
 =?utf-8?B?d05CREhjc1R6TXk3b1ZBMWV3TDJjeklnemxZRlNMdFB6aHNNalBzeURFb24v?=
 =?utf-8?B?TEVHWGNiRWl1bXdENWRiYnl4Rk5vZzZQR1hucFU0b1NpaytFUzBmYWQwZEFn?=
 =?utf-8?B?Mldac3BQREduR0Z6L3R5czNNNDZNNENGKzRwVmNZMHpOTnZYQUs5b2dkdEVh?=
 =?utf-8?B?aXJEaEhGTjNRdHlPbG5DbExXUW1LV1dEUXpnM0cvWkVDTzNvdUJpSWhEZ0wz?=
 =?utf-8?B?V1dndWdPTVZnVXg4RUpxK0lmWU43Z0JMaHIreElTWUhWaitMdmFZazQrZ1FU?=
 =?utf-8?B?WGlpeFo0WUl4S0MxV0JOSHVvSzNmbC9rVXhYOFVEQ2IzOTBmQm5aQnhiK2pB?=
 =?utf-8?B?alJVN1JXQU9LOGtSbEZyNEptckxncnFoS1h5N0xTR3FTNXpSZEtjc0p2Rlhn?=
 =?utf-8?B?UkN2OGFFZkF4ajBKS2tSRWRRK3RKdXgwK05SdXByRW9DVHFWZy9xc0k2RHVo?=
 =?utf-8?B?NVp2dTVPZ0tWakp4MVdWNG56ZWd0STM1dE5rMWlUL3I2VXFCRFpweEx0Uk8z?=
 =?utf-8?B?aWdVbThZbXJOSUZ6NDhvRkQxWGlFRkx1S3pQTHZvOEc5c3RlZnMxb3VPUkx4?=
 =?utf-8?Q?G84p0XwQc1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V095NkJ2NDd5cXZBNWdMR1A4QkROVGtyRDZ2bkw0bUczblR3d2VRZHlRMGU0?=
 =?utf-8?B?WFlReFdZYmFxQUNwZmxxNjdSVDErcHZnbDRJNGZ2M2xnbTdFOUNVRE5icnZ0?=
 =?utf-8?B?T3ZUb21vM20yYzhQNWszRlRlQ29Mb0x4dTlyd2pPTW1vcWtRRk9RWE1TVTBk?=
 =?utf-8?B?anRqSXNuQVAyY1hGMmpSQit4UnlvM0tVU3dpaklPNDBxMW5JV2FZUnRSdmU4?=
 =?utf-8?B?K05qUEU5dmlJdytuMlh0UXVOUGx6dTJBRFN0eFY0SHYrcEo2WGYzVmwzSG1Y?=
 =?utf-8?B?TjZyMDRzbGsrcThpR0ZzYjNCSFhYU3dZMnB5aHFaakxSd1A1dnliOUk4Ynd6?=
 =?utf-8?B?bUhIZFIzdDZocXcvTkV0QTlLSDgyRkJxY0NKWWpWcUQ4NzJPUXROQlNRWmls?=
 =?utf-8?B?WDNuTU5rOWV1SW14OFdMS3VUTDhaMVA2RWNTdjQ4TitZZE1DMHErOHExM1RJ?=
 =?utf-8?B?QnNZb04yRm9aL200SDZxMEFrZzIxdHQyclZFK2lZYkpXeVExcitYSmhma0k4?=
 =?utf-8?B?bE9CSDd6TStQNUN2bzNpM0RlSGd2RW12TUJzazJDVVRNSVc4SVJZeEovY3NG?=
 =?utf-8?B?dGM2R1VubTlMNW5wTE52ekVsb2NZcFNwdy9Hd3hkaGd5b1BRN2o0eW1CNVVE?=
 =?utf-8?B?Ry9CZUJ2SGVPTUo0TGVHZTdCSmtleXlnenlqRW9hL29NMnVUWlR5MkRGSi9x?=
 =?utf-8?B?WkNSUGdhTlFHUkk1OU9pMEE4MVR6dnNlNU80UGFOa0NnZWN3OW5LalRZTnc5?=
 =?utf-8?B?QjBJNDIxYUhtL0ZvejJGaW5kQ1pMeGZMdm5TZXZRdWFMVlJTajNNdUxGWWx3?=
 =?utf-8?B?K2NXS2diWEVKZWlreGdaWmtPbmlYdHZNTFNyV1lFYmVRKzNDOHFzN2JtZy8z?=
 =?utf-8?B?T0FScTQwUFNIUDNRSzUyMnM4anlDLzkraWY1b0p5RzlzNFJESlhGZ0R2YWoz?=
 =?utf-8?B?WlFqVHh4eWxHaTZDbmhuTEZEaGpWRm53Q083dmsrN1I3bUFRSkVuK1RFTFMy?=
 =?utf-8?B?R3R0bXpXaEhSa3dyai96VjVTUGRGdnRZS1NMNU5lR3JjeGs4SGo5djZFTmRN?=
 =?utf-8?B?dmxpR0dlcmpINmRzakt1SWpVN2tzb2xHWXhKc1VxZWUyWVVkTGJpRjdYVDdm?=
 =?utf-8?B?UnNDQlhIU2VmVEVrTHN2MU1URlk3UWlicHl3am1jazk2NkFXYjBXbTd4czRN?=
 =?utf-8?B?b1lnNDNHakN4SWpOMzU3aW91UzhSakc1MExMWjYvbC9uRUJ1MzF4TUxlYWw5?=
 =?utf-8?B?cWRjeTZhZHZ2UWkreEVXZUQwL0hiYVhVYXRsNWpXN25mQ3o5VXBxb3dmQk9w?=
 =?utf-8?B?RW81YVpDREFSZzlYZXJyL2tTS2xsWGtvVmx3WWNqWWZwSm9rbmhUUzBYVG5X?=
 =?utf-8?B?U095aUNhVXp1eFg4WS9zSWNtNlMycFlCZUw1YkZxR283MXdYSWV6Q2tsejZF?=
 =?utf-8?B?TzZIcmhMQkRNZTZEb05MaXBSWVRGMTh4aHZENGptN3hTbVE3N2E4VnNQdkxF?=
 =?utf-8?B?a2F4V1FBQVZQMzBhd2FLbEw5Q2Q4aVJBZHZWNDBERmRwWVQ3WjVIVjJ3QTNj?=
 =?utf-8?B?QlNwVzZFRDhDMWUzbEJocjhsZTZJdCtqcTNuSkxXb0ZoV0JqMmx6VDRrOVhz?=
 =?utf-8?B?ZUhFSUZtcTU1UnRNMFJubnNzOTRKOGY3bm9jbEV6NzVvbWQrMjhiYlRENkNW?=
 =?utf-8?B?aHZsSlRBZE5jdXBtUjZXalhTaW8xRk5La0cvZVg1YUgzYTgvckZOR3ZDV0VT?=
 =?utf-8?B?b1ZhTnZhZmpVb2F0SDhlQ3d2N1RJVVE2UXU0UXB0UktSRU01ekZTNEFFYnVp?=
 =?utf-8?B?SjFnMFNSbU1GQi9PcXdaa0J6VnZlNlE4cGdvd0hzTGpRQlFnWTNMM1FUM25P?=
 =?utf-8?B?NmtzZlJvNjBBQ3g3eWtBajcyS1BNbzdkZXNHZlFRT3E2V0Z0c2h0S0xrRC8v?=
 =?utf-8?B?a1FCQzhKWUNuMkN1Q3owcGh1VzhEMkw4RE5uVXdPZWxZaVYwbkNheDlaU0hk?=
 =?utf-8?B?WVJvaGI1ekFLWFgwZURBdGQ2UC9oU2VPVVVBeW5TZWFITGdUSnExeS9LVUs1?=
 =?utf-8?B?UXk5RkFuUzFhQzdLZU9IOGhlak9vUGhqczJGRmxnb1N4NmcxODlxSnpqazRk?=
 =?utf-8?B?NXlVK1E0VGJkRGkwTytKQVlNS0NXWFZHR29veWY1MHc0U3EwUmdYdXdCeXNB?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F3JRsKgEFmOUx/zN7s53UMdKranAERJCfJf3TJZrWEGZB+uBEOlSVmCpIYULah7Itffka/JO4yKebJrG87kJni/g3mfiD2f0qXpel4wVbncn1JH9B+2m8WjNONYucXysHnmUEM4NlAN5HDa8/SH5PakqOBFl6hMg7OlyHWrqeZ4LhRoO5mBjsP4+enCfXyJFvuS15fHlxfzDzW2L3IJNxvYSF1saGPdGzHERWA8Dojilb1XhxLjVhkVoDTwvaNKkPshZef3E8F+6bfyo7EEgjUV+Hkqsf8z4ic5QjaYNKs3r8uVUt48Hb2Z7TEiciW9vFQHCMq6Nn7j2eXt0t6bGraLdtKvqm3VACsHsw4Ox6lOjTdfdEzuau4Zy/W0RcQZXteNbMSxpmz5yyofBxdgqWRz6uuUn1Q2WOcSB0xMc5VTNnhFR5+9JcYC2rTH3POHy9Zhady0bmiXO2f/WF/MzDgbki8nYOjqxKpZFN15oz0kUjKAC2vwEW17j9IfGtKywheEh9yHOf9TiHhMGQ4PRJK5hqb5zmlEDHk9LyYJuCf/4MgkYbnDzVAifKUAW2m0jiwDzxym3gK5akOw7tJIjcDfrvAQVyG8yFvwmZixS4WQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc6298b-21db-4bd9-d956-08ddf50f9d30
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:55:56.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0ZWv65fWj25iG4US9iY9YHjuFdjSrBC2WsfmPnBEB9e54PlsMYVBas4lUXbmd5uB3mwHm33yXofLPOGVQ84ndIwtNGdg/3NNnOeXBfY0lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160104
X-Proofpoint-ORIG-GUID: FS_FzQjLooG7DRyizac7Z7QbyVdzroub
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c94240 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=vAW1JPw0gB4noFN7JrUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: FS_FzQjLooG7DRyizac7Z7QbyVdzroub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfX4kY7JLW288rp
 M94D1JG7d79Qrzwrzlh8wl0rMP8vPXhf4ScG48fAuIUNDOBzLSTWVB8VaG0eB0CtsyCWkTDupTg
 /wsJtVWJh60j0wMVlsMHNS4ansmMGx72B31SCODVhSRHIDrF1eLxjDguBfS6wk+0s9LB7NR8w3C
 43v+zr2f90l5L+MS9DFXqV3kleGSFyC9JN0Hv9TkPMSBMaOis4U1ecEnSa/VwTyeBicSyEt1e0w
 yd9TpkAB9Kp4GjmgdK4fA56aTf36MwVLhSbRqOQxqQP33NHyhJzMdWlLwSZ+R+F2NMSdCCkcCtw
 LENvUVm1nv/HIhYRcIkhyaFPvSdquZckrSt7KrWk02cZn3aUTPRYHzqJWN0hA2fRMIKv7WBBlbZ
 xdj3lwcOoS/qTpaRjI07m7FC+fzOaw==



On 9/16/2025 4:13 PM, Devendra K Verma wrote:
> +	/*
> +	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> +	 * of map, channel counts, etc.
> +	 */
> +	if (vendor != PCI_VENDOR_ID_SYNOPSYS ||
> +	    vendor != PCI_VENDOR_ID_XILINX)
> +		return;

if, vendor == PCI_VENDOR_ID_XILINX condition will true

should not be if (vendor != PCI_VENDOR_ID_SYNOPSYS && vendor != 
PCI_VENDOR_ID_XILINX) ?

> +
> +	cap = DW_PCIE_VSEC_DMA_ID;
> +	if (vendor == PCI_VENDOR_ID_XILINX)
> +		cap = DW_PCIE_XILINX_MDB_VSEC_ID;
> +
> +	vsec = pci_find_vsec_capability(pdev, vendor, cap);
>   	if (!vsec)


Thanks,
Alok

