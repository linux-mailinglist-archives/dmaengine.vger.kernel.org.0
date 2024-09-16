Return-Path: <dmaengine+bounces-3175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724497A759
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53292B2388E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048A487BE;
	Mon, 16 Sep 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0Xa+Gt/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yh1e/RPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40E38FA1;
	Mon, 16 Sep 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511692; cv=fail; b=RC7JtNii103m5o7gVubtb0JajZIHbiiw10gcgDX8VFwK3x/l/xb1rTuJiVGQfEUkL4pinpbiCZeJWVsLANMGsCzBKDlrsR5AVfMLyprxeXoGWIbWceNw0rkzdets4TeZ6YlR3b2Vtoqh0hb/qqJFbXG48j36MUxKBjN5pYDqLFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511692; c=relaxed/simple;
	bh=bXpb148gTSKideswOGb/SHBWLMQyGLLXUSYM3OccP18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ha+PgRFzzeQZF93z/y4tp3rWWGrTyQRQwbp11shNfI53989T3XrnxdGXbNOh2gD6w7RiCLDG5fPbiRd1rR9b5Zbnzgze4TYSiS2YaxEz7ycKblYCM+LBYuKUfbWVMVI/rIQVs6w9iS4bGF1EZ5uZsLCSRtlIyEkFSAq0n9QxY3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0Xa+Gt/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yh1e/RPy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYv7022225;
	Mon, 16 Sep 2024 18:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=lTsOw9cMh/lW30K69YbpepdzrPXinLPejXv1LqVRtLg=; b=
	f0Xa+Gt/zufEISGDeMcuRMdbbcKr6H93RhABGpP3pwYrXy3fDmhcawtIwU8uyytu
	VZm+ZQilmboVSa8CfIPFbBhath/xyFq4/sWpMOz8OxwMCCq7Or+SltNEV5zzx2QB
	QyUGOg0rBO175S93LiGEi0F0jeKhl90rpKGSBg7pwzdNTT5LA++Rwgg2b06mTAXK
	eRwqo4mdXk8X4sItTUwawlUgQQMlq2SYHwPr5+61lMwh9wWcaGKYY/F7i6bwHHTV
	1vdT6NdK5rd+rJxxHbLOdEByTBKX1yaWvTffro5cSVIG4pXk22ASrBIBxibTaqzm
	NIBnbGAcRvghp3mZUIgV+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdm3q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 18:34:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GI0uEQ014907;
	Mon, 16 Sep 2024 18:34:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg27mmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 18:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA6nbEfjP0QFhGRvF42mwa3d+tMcIW+FWT+fT3JS2wcZtpJyGWYtM9ct4MqXOUWYaKD9z3DnZPfvHYtw7BkhWqZDxbgYEL5RxrXG0iAG9qQMhKaxSVhVR5p8/c/Hpk8DKHiAStbEf+A3g3oOTM/c+5FfZodixHbCONiexfA7zzp32PynuHbecbPsnCwCRZEhdFU6m7JUhAr1HX57J+Yfq1oWjNhEd/3cqc3WvRuq7X0A5X8NUADx5FrSKvap221jUgS+Q/xKXzogUC+KNRM6MxOF6yYsDoYLv4vS+lbNg6ZnhXsCtrCoO6vQFLF3XMggvT/A2KP0Di6GjjbB9kkjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTsOw9cMh/lW30K69YbpepdzrPXinLPejXv1LqVRtLg=;
 b=IZrQ7Z0I1YPrXTqc/HbF2xQmeNgXXWOCT138OdEJk/PqkWN7IxdaHJA48JBMDwwSAV7GkTl7q8uZYiHJbC+yGRyoUwKg64Y9VzZZxvlEgB5Y3f5B1aDhs9AFVPlmVp2y8Yx84F+FKg/kdR5lV+s27BGmG2FLvHf68REPla2hn0eczZ89uUDDZNeMYK8Ht0BDenxXOYCNIIjC6vUp9AnyyUGlEB4gpPLunelqWfYiyM+zKpntzSFHY51MCNfNmMlGnuLYQg2J79j2DypPH85nQN5rtI9tNgKb9VD+Sq1uBOQaXG9drmke6WV3BVS9aAeOcFa79GofYpHpmkrUoekP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTsOw9cMh/lW30K69YbpepdzrPXinLPejXv1LqVRtLg=;
 b=yh1e/RPyflWKCYH+w1XfaABmv+HD2Icx42zfcK4gEYmSPrjH5jSeS6RqkXypPrkqIWtbys4lW5HQ5NPJdgGE3a+0Ph4v5XHW2O+f4bbjxkiGDVS6LjSca7eJ8BSpNZvnCPBLZHlNDaVB3xAFALpuFVKXrq9ccjhNoIOepPO90H4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV3PR10MB8154.namprd10.prod.outlook.com (2603:10b6:408:290::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 18:34:37 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%3]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 18:34:36 +0000
Message-ID: <c44398d2-8322-4a3e-b7cb-80b40d7cb079@oracle.com>
Date: Tue, 17 Sep 2024 00:04:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ep93xx: Fix NULL vs IS_ERR() check in
 ep93xx_dma_probe()
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20240916182337.1986380-1-harshit.m.mogalapalli@oracle.com>
 <75639e2d585a2d45e015e80044c0f88a3f5ec3b1.camel@gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <75639e2d585a2d45e015e80044c0f88a3f5ec3b1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0054.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::8) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV3PR10MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3edd91-3557-4c7b-dc33-08dcd67e378c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkcyaEl5YkhpaXBMZlFMcCtNOWNjZ2lsTFZOS3NJWTMvL0FNMFZvRVZQVjVR?=
 =?utf-8?B?R3hpK0x6dy9BcjZ4Sm9LSmNtb0s2K0hCUkEvdzN6WkZkYzdkVVY4WUJ5aUJ5?=
 =?utf-8?B?Q0RlSWJ0dUlKM3NaaTJLNFVKdDhlZFcyekVSUjg4OENpNXZHUlZySDR3WUxh?=
 =?utf-8?B?aEZwelVhNW95U3V3ODFtcmpqOWRNMmlyMzdQSzViQWpSSXFIcHAwM0VvL1pn?=
 =?utf-8?B?SHFGRFZDOUFib3lCKzk0d0QvNW15akRFK0d1dlRrd1BJYjBzQ0RTTmJicHhz?=
 =?utf-8?B?b2MrZUxta3pwQnZ3OVhlRjM5aW5ZZlZKSkZzTkNjQ0U1aHhiMExjSmVjRWhr?=
 =?utf-8?B?RUxkZ01paTN6Ny9MM0RBQkl2QTVUeGhkcXRCc29XbE11N3ZNTStqSEZ5aFhU?=
 =?utf-8?B?dmRKY3lLZDZqdUJDTWVwL3RnS01jSFlCWUtqOUs0Y3V2aUxqU1RPTWp0UG54?=
 =?utf-8?B?eUlSeXRpUlBQcUt4WC8wTVo0bDJxdTlVOUJCSnVXMUxJYUZEUUM5RzVWQ2RS?=
 =?utf-8?B?TStURlhQVnlDNHVFVHYxUUJMTkZndWFSYTc5cWNOblhjay9OazZDL2ZlR0sz?=
 =?utf-8?B?LzBJTGxnRUwweUJ5VXh3em80OTFOSW1ZNEw3enB0RUViTkovcm1BbWJOUDNo?=
 =?utf-8?B?Q2VnUFNRRFVGam9Fa0ZUSEcrT1k2a0V1czNpaHh2WjZUeEsrSVZ3clcrR0xF?=
 =?utf-8?B?Z3g2NFVkSGNsM1BHUnhoRmJRdnVXMkNqVzBiQ0MxSTlXU3RoSElaRFNsSmJt?=
 =?utf-8?B?bG5DYVhtMkY1RE5IZmVGOFdnMGgvNFpSbDBtb1htRzIrMlNGcS9Ea1FrWDFv?=
 =?utf-8?B?UmpsWDc0WDJ0ck9WOVhFMEp3YmRaZWNadXA4ZTN5OHNIT3pBdVZLa1hGUjJa?=
 =?utf-8?B?TDZ2SWt0R2pvVWhnbUY4eW5hbmVsNG1wdmNIRE9RVzJWelhaRVFpZmoxZ3hO?=
 =?utf-8?B?blp4eW9SMkpiZk9SelRrV3RoV3FpeVpyeHJ6bHhZTlRmVVdqdHkzdkdrQU14?=
 =?utf-8?B?R2N5djZBQ3hkMFFEWW5DOSs5OGZiK2N0RWsyNURNc2F0WlhmbmdBdzFhYzgy?=
 =?utf-8?B?aTQvK3crY005c1Q2RDkxaEppNWQ3dmlJUVc3WTBpVDBrUmFSUlZMYld2WWM1?=
 =?utf-8?B?MlB4N1RZTGxEZDIybkc5ck5LbUlKV0VTcjhLWHVYZzk4RVBPaVhiclZ5REdz?=
 =?utf-8?B?QkhiLzZWYzZSSFVTSVFFcmRRRlNWMkdhYmsrc0REWmdyejhmOCtvWFpzcFcx?=
 =?utf-8?B?MGlpS2wvNmg5WkF3QkdOTHh2MHg5NEt3VVEzd2N3eHZVZElVV2w3bktYaEk4?=
 =?utf-8?B?Y0VNbkhrdFd0VCswZktoTWJRZERwSGY0Qk8zNTVBMGNlMFU0Ykw5eDMrYlZp?=
 =?utf-8?B?VUF3a283d2NUblNVMkFLUS91TW0ybFFkMytDN3VRN0hsb2JpZWJjVnl0SkV0?=
 =?utf-8?B?ZWFPZmVWb0xFOTRRbmFBR0xzZ2hkd0MzNUlDUUFySEFiSW9KcXg4VUQ2SjJj?=
 =?utf-8?B?eDZiemt3eWxqbElwNVZ4YjVZOWY5RDIraVVhNWFRa0lOaE5vaEJiS243M1FO?=
 =?utf-8?B?NW9TcUhEMW9idnhibTkyZ2N6a3ZiWnFNWTg2U0ZacFp0SDQxTXhnVUFrMmpT?=
 =?utf-8?B?MzBzTlpDNUFnY3ZIY1pseVE2bTlEeUpCUklhTjVlNTZQTzRuZnZHWTFFeXF1?=
 =?utf-8?B?UCs4YjdYaFMxZnFUaWlZMHZpRm9tSHFzODJjZEJVbEsvTWFoakQxdVgzL3lF?=
 =?utf-8?B?d1hTR1dMZW1DY0wyYVN6MzVzVmZNYjl6R3c3Rk1mekNVYmpFUW1SWHlOcFFM?=
 =?utf-8?Q?YRuPIMkL8fb8uWZMmXuLIefHUaNKN+SJIDTY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZhVSs4ZVl2SkV3ay9qZllEM2Q5c2JldnhlZjQvOVJKZm1QUEhBU0lmVEoy?=
 =?utf-8?B?Zmw5NVpZWmVWdUhNVFVoOEk2RmhiVEwwTFFiMWR2RGtmbkdpemVoaWUxeTV0?=
 =?utf-8?B?SlM2VTBsN1ZBMytNV2E0eTlFTEVhWHJPdmFpYU5pUE9hQnNxYjNHTjJxTmZ5?=
 =?utf-8?B?RnFNRDYwSTRCK2s2OFEzRnh5ZmRpdGZwWnlYaTc0QU80T2JGN3RVcXA1NUpU?=
 =?utf-8?B?dGk5ZUtNRVM5bmN2SnA0QzlEb1FCanFiQUd6WXRMWkpKWkVQRVNIUFF6UEdw?=
 =?utf-8?B?cHB0RjRmSHJqWEpMckVNczk4bnhsUk1RTnlEVTZTcFZsRTZackJDa2k1L1hW?=
 =?utf-8?B?MWxlM1ZsRmxibWFPMHZTVkg3UVEwOUIvYlZWeFdXb3I2NU5MazdsM1NWZzdW?=
 =?utf-8?B?dVlid0VudjRweTNIZXFXNmFuZUdhOWQ3amhGcWVYY2FQRU5udVNvNDBpclFO?=
 =?utf-8?B?UEpIUXZRbEszUzZjMkNqdFRnNWZzK1FmbFV4bXBYNlNKL1pWOE04TGpYZVF4?=
 =?utf-8?B?WHNMMXVJRWhBSXozQ3J2V2lER09pdnN5OER2WG84MU9sS3VDOGgrSUVpWUJ6?=
 =?utf-8?B?R0pMNTZDbURTdEhIWTVXOEhNZzZWOUFVMmgvVXhzM1BaaGg5NnR0TE9nQXdH?=
 =?utf-8?B?anR0TFZOL1ZRNHFyeTZ2dGZ1N0o2VmhadzAwMXlkNUMvL3Ixd2p4VExKak9q?=
 =?utf-8?B?YmdsSStkM2tWckJsR05wT1BEMTZtNlRhcEowT0tBWmJ0akR2YzJQZi9WR2RI?=
 =?utf-8?B?SmM3RUJLanRiR0JPblV6N01HVkd3Z3I4TTUyeGQ0K016d2ROQ3pWWkJjZHRK?=
 =?utf-8?B?YUUyejZ1VEZuWVptRzNIdjZydnhQck9rYWNBOVplZXhiRWs4eDdtekhFVzM4?=
 =?utf-8?B?TW1VYi9wajk3d3crZUhQZUZmeCtZejNWa1VIL0xvbVJLTHlaVmZ1ZG83c3Z5?=
 =?utf-8?B?b01RNnJnRHZPWHJjSk03WC9CVEhpczlDckFocno3YzdDZnJOaUJidnR2Zy8z?=
 =?utf-8?B?V2kvMGZXcXhXa2pCN2wyUnd3cGd2Qzl5eTF0aWhnendmQnF2ZDNCbUM1VXBz?=
 =?utf-8?B?UEZQWUpmN3J4V0JzT24yNWJNMmR4bk0rOHhGQi9XTGJ5QW9rZ25MenU1L2pQ?=
 =?utf-8?B?K1haSVQ1NW4rM3E2alRnRnlkZzN2cS9uOWtYaUFJdlJVa0tydWt6RDM4N0Ur?=
 =?utf-8?B?OWs0aTZ2VTFkaDE3blJmYVRibEJaZncyYWVhTXFodTJReGo2aUNGbkthZXg5?=
 =?utf-8?B?TkdrTk5EdXZHS2xuNllUemlONFVMd1NhcmJjRmllQ1d3RGc0OFVMZkZ5blo1?=
 =?utf-8?B?ZGQ4NDJSR1hZbnZPRVRoUkwrOG05U1E3MVNndWU5YXdMV3FFSmg5Q2JzYisv?=
 =?utf-8?B?YlJDSSt4ZFNuMndubmdpK0VrOWFIVFdwaG1yRUgzUnNWOFNrZ1lzV0Q0ais5?=
 =?utf-8?B?RnUzVGZQSjlWR1RoTEtCaG9saUhqYmNFclRWRVp1dzRCaFBaQUprUnZYRDVR?=
 =?utf-8?B?U0lRN0dEcFcrMUFnQllTZ25Xc2c3cEF4VzFwVjBmc3p6MkhXRm1SeEJBYW5X?=
 =?utf-8?B?ZWdSMERPdXdYRVFETWMvTGRobmIvU00rOC9VNHREVnNyTUl4M1VKSHF6YVlz?=
 =?utf-8?B?ankzT1hLTTZZdzZYOEJjbitrd0xWTHRMU2pIS0JjdW5odVFZVWdRbTJTa25y?=
 =?utf-8?B?UnF6MU1VZTR4TERKUzA1dXkyd3pDT0pnVWROMUdvdU9CRUZWWG1wckZDaFl2?=
 =?utf-8?B?Myt4S2NSWDlGOTlrWm9obGdWeHRGSm9UQTBVNCtlazVHZmNvSzN6ZUJ1WmNL?=
 =?utf-8?B?OXNnRjNSVTlaYjgySHQwekgzSjRvNktUT1BwSk10Q0VqUHhQL0hLYjR6dHFX?=
 =?utf-8?B?Y0FLd3g0UnI1MEkraWxGU2lxWE9IdlRiOFJOa2NWS2wzZjZwUGZMVTB4Y1Zw?=
 =?utf-8?B?OEloUGR1K2lLK1lRRFhiejRSSnZYMCtsVGllcDVIOUdzcEU4K0VsTHJBYU9z?=
 =?utf-8?B?NFZBYng5TzFEbEJDaEFXS2tqMjUxSmZsUDA5ZitrZWxZNjJSaXVGQTBPay91?=
 =?utf-8?B?NGs2Tk5ZeFo5ZEJKV3lsZ2ltNEp0d2hXVk5HaHEzc0l2d2NyK0h5Mm5hU2Zr?=
 =?utf-8?B?enVNSVR6bWRQSjcrTStNVEhSUkZLM3pmZTY2UTFDb1lXOGlhUTBRTnk4RFJV?=
 =?utf-8?Q?rhZsqXZEY0s080BMUjdhhsU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Jvn0APZNo8Lc90kvbaP7KaWlZr5FE98kIjveHUu0YndUymq543jM4dcq7xeUyTNIuo4ipAuGtNhsqy+Rc0ZbEmMVPL/vDTcb61XAfBIOYti4Z9390E+q9v4I+lnJfqonaxmX5Oy/UfKahu72zodD0WyoeNuFnPR0lPoOqYd5SovCJbJKAwuUFPgZzspk9mEOS1chSYDoawFjbem2xMxE9Tecj4nylHsZ2j2XP9hGhZoqLPco+m38YAjlXGoAtqQh48yuGSbhXkdGm88Ldu1FTxw8mm+XY1mG7wLXCq/76MzeRT5ttgwaPmH1Rp+o0Ba8JwM73x2JPBenEjUZwrQv8OeuBNfkxyrgb5OUefHjXEORzhewL3Gwzt3UTNvwr32UYK6ZMBdF0JPsHJe+U2iXWKA43eQQCeFOMpJYnjgmOvvg+pWkrAKgOIAjw5qOtWWAC03f3u0QOY1gDNqdYzOztO1oMnJ8QBD4vFX/vduRnypU3gDEDx3T3mLXL4LZASY9lJmkiR8jwifQIqr4kqEf6mxrLsU+Jcrqol9SDiAgMdFTF9anGfQHZQX5GMcvIWZUmnGUmQWBopdmy99+xToEEWb0pxkrT6hEFluvNB4YHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3edd91-3557-4c7b-dc33-08dcd67e378c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 18:34:36.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty/Gfm3tMR6H5inLo6Pj6RscAIcvLX3aNhNvYZDIqqTT4GP4Nzpmlup9KT7xR7GR/vyjv1M9q4K/XW5kwrDWd+obKHlarYb+Z2A92ttQdS9heeFtIRSehTLXexIrDYKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_14,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409160125
X-Proofpoint-GUID: n51e8fP5IsiWLuWtLX2I5uGI_JNCLhmT
X-Proofpoint-ORIG-GUID: n51e8fP5IsiWLuWtLX2I5uGI_JNCLhmT

Hi Alexander,

On 17/09/24 00:02, Alexander Sverdlin wrote:
> Hi Harshit,
> 
> thanks for looking into this!
> 
> On Mon, 2024-09-16 at 11:23 -0700, Harshit Mogalapalli wrote:
>> ep93xx_dma_of_probe() returns error pointers on error. Change the NULL
>> check to IS_ERR() check instead.
>>
>> Fixes: 5313a72f7e11 ("dmaengine: cirrus: Convert to DT for Cirrus EP93xx")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Dan has already fixed this though:
> https://lore.kernel.org/lkml/459a965f-f49c-45b1-8362-5ac27b56f5ff@stanley.mountain/
> 

Sorry for the noise, I thought I checked lore before sending, but I didnot.

Regards,
Harshit

