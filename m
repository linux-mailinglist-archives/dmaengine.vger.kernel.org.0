Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87BD69AD78
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBQOLj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBQOLh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 09:11:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387596B326;
        Fri, 17 Feb 2023 06:11:24 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iL1V009708;
        Fri, 17 Feb 2023 14:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=K7+UnXK2WLV7CcSM/cDKNI1KqeYFHDlS98+fozpeYpY=;
 b=NWSHsm0DpUxR+kBfxToWdkTHesFOp5HE+mEG1ksB5WnjHN5NSZAkRwirTK9/A6qbc+P+
 AgjlIl4Zc/ow+atr+3dBOqhTAD3Ef9l20K4E/49G4fHHER3o8wREMNowhrig6GmUF4b8
 iqg/KISUK9/gOlxqVNwFE7jSJkwx6uNk1gn05Mn7YFd8dx9NvsjNm3MX00HJgz06NvxQ
 9vZeLYcyRtCUSNP38aO3D1i9LJX+eZukJQceJyO9/PqyFwdWPuOfwBz8Et1thbyyf2UO
 Qj1FGlhj1skaIxTv1cK07BnihzEKv6Kn3AGJu1VAHUoFaFYtJO3fHO3kPRWoyiJM7n9d YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xbe000-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HD62Mm012207;
        Fri, 17 Feb 2023 14:11:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa4xx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5NOk7E7H9vq7TAYsuueBMRNn3kPc8KLVuz0gLSvzidkljLuVFqgx+ptYmSW+gZX3/eNGrm3r6xwl240LSlpdbbOgwWpCrHIbumgYaxtBMfquP/ios2lRhOwRgjxxcRCwnMokmRn+zsBlvDpxuWyHQYE3dzcC0YwEPe4/irrFp3B90WwhRX012N298umQ+DQ6XIAjaYYqkDLjaLYm0v18MWB3yT0ooqgkvUYwJ0STn0OT+y0n2UC4sxNu4CTK1VnzZYc8Kt/S0uj7DmO/d8xcqo4caljjZzGu9wN5ndKedpt9gLfNtZDW6iiNb09oRodAoLdD3zFWNoyoVBrzC56BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7+UnXK2WLV7CcSM/cDKNI1KqeYFHDlS98+fozpeYpY=;
 b=dIVMiI+yKXV0x7ItUu8/FHO3ibcLG5c5R6Gehibx9r3h3G24IdxdSGLvYUzkmfM4UCfi+hHMdMm6gWs264YRcbFQofonwRHjSw1ZmurMOWi6Bgi2WJB0auvhiXcdWQAqZvBZvlfxDe/Ldguwa6U0iMiCtJWAEUWLCzYVolUWL4tPUjjKy5M7vClLp8zu6lr316gyJc7oWuimCeFigWOM492LOR18kn969Ur+9Zd/pwWRKKhkdon3ykdrvphd/eZfqjHEy25Ikm73e89Mvksxff1hWdosta42PapMgja07mFfRjgyXyhCZ/+XvN6cR9yxHByEqHxhNnV1Fxmgaj7IUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7+UnXK2WLV7CcSM/cDKNI1KqeYFHDlS98+fozpeYpY=;
 b=Gk/161htlCWOD7qqiwROsgrM6bEszgZ+amJjv+dVPExqg92kiHr4sEk2vAclkr50g3HHeYNTpwS5Ry6DOT0sQdlLee9SedTApeOwo8RaZElkYqLFpZaJ+GJhsssI5XXa9n0H+2/Mkqx9u7sUX6U1r5EMNEi0JF4+4EeNR6vOtlc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:08 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:08 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: [PATCH 00/24] MODULE_LICENSE removals, second tranche
Date:   Fri, 17 Feb 2023 14:10:35 +0000
Message-Id: <20230217141059.392471-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c1f1ff-29da-4678-bd5c-08db10f0d0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ECTI9QOlf0CPWYBDEyT2+20r24al0XRr/M+abTL5P6mY8ZgWDD+Oxbmy+EkdQdEWy1TP3D1ckegnwup+CsgZLUzFiSE3M1kPgVQvSOrh2sQctOTparrq4n1kyNAmeKADeWKD+K+nvaa5W+q27lrhVLwfUCsy3ddytd8/NEQ3nUEMmBYmdsmyA7dxuYJHN9I96HnwV07Lrw/0WKGJOpXdw3bQy2R2+OgZNVenyjXKeR+FSnaweV19gtPfP7wKsDaF0mp/TUiVOrVRYVTsnQ3fZDYPyny6p42chYlrw+GYQkcuurXoT61PCSaPIJ6TwgMgGdG92xs98qheqVH73rTSpFbuHVIPavUDrMuQC3/Dw/HiYDCJZDS6HPRFISsfB5Cb0MuiJomGAVdZUKBy4TQJAJfWw9gKUVQb72YbncNd23SCxTEKt4uzBeuf4FlsgDDRZ2Uob1HUFLmBkj/ThBeapftz2cAX88zVRHxLWoKNzao1pcb0WdRp6JmxYiYa41G6/wcQqyk152AA0jV6DdmiIzAtA0n0z+McYN3EJ/zWmsSWTM9HWRq/vnmqmIlafuBylvkCegBnQH3CKlMXqROLW3fmDGDz8+QgMqlf0B/8soXBFX9OSV8EFilvZ23gceQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(1076003)(66946007)(5660300002)(8936002)(7416002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(966005)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hiYm1HbVBXemQzNi9Qdk5nSFV1a0FydHM5ZlNVT3dMSGJXSU1hWGVwVXpU?=
 =?utf-8?B?SGJ0T1dsZGRnM3g4RkRGM3Npd2V3cFl2bGNOL0tiOGZ3SGZZZkR3dEFqTWJ0?=
 =?utf-8?B?a0xVOGJzMmdDQkRGU20yV1BSV01qNDN6YU9mMVRDdFhzR3JzQXZxbFZGY3dn?=
 =?utf-8?B?SUdacVFkeUZOdjk0T3F4VnN4VVBVL0NXNTErS0JvVFUvQXVhYlFOdVRJM3hz?=
 =?utf-8?B?Z1FqbzdaR0lwK21taUtBeUZrcGQveExqRTMzdmdnaTQwei84dDFsdkZpR0pv?=
 =?utf-8?B?M3JCeVNYSWhiYVNWdGlQckpFclkra1lxOXRNVUxSamxySVZkR3d1U3hVZGFr?=
 =?utf-8?B?UWhyNXkwVnRMU3VYVDZLODZ4ZjVNanZoNGgvUHg0VmpuejFLWFI1eU95ZS9S?=
 =?utf-8?B?VDArbW9uZjJQVk1rckswQ2VPYkN3d3JoTUd6MGhRRk40dWh4OER5QWZjMlJa?=
 =?utf-8?B?RjF4WHpwcHRxOWtGNmFyWTd1bUZaMGx0bU1DVFBNeFBZMzBvbWdocnBFSHVP?=
 =?utf-8?B?R0xHK01SdUpGQnpzcnZUWVVianl5dXBMeEtueDlrNXpjeCtIQ08vNGI3cjg4?=
 =?utf-8?B?VWRPVU40b1duemthWkYzckdEQ1NQbXVIcy90dFA2eU12WlRHcnNITFVMUU9W?=
 =?utf-8?B?dUk1ZFRQMFByYk05citiZDhXbXd4c0l6QytZTy9pNDRBeSt0K3p4eDBwWlNx?=
 =?utf-8?B?TXM4MGNVRHQ5OHNtR2xDNjZ6bmF3c01hUzFhalJpZ1lrZTBzbys0MHk2RUlp?=
 =?utf-8?B?UDZiTVM1MzZQOVBoS1czMm9KT21DYWlQeE4vcGpqUDdzajNIYmRHUTNXUnJC?=
 =?utf-8?B?YVR4SlhjdjhkanpyemlsdHduQno2MFF6SFVXL1YrSHkrdUFTSDg2M1VMVWRM?=
 =?utf-8?B?dW4zcEYzVTFsbEhTMU9US1pMaVhmTU9aMi9ZendIVkJ6TUY4dFBoUklGWmNU?=
 =?utf-8?B?eEp1QTlUM0c0WlF2emxhZy9Ea2gwTEtIdktldG5iTlA4TjZYK05tQnV4aUF4?=
 =?utf-8?B?eld2VlRXVTRsSnlFQjh6Qkw4bVhSYmZscC9NTTA2M3d6YkNPNm92eXAxdmtL?=
 =?utf-8?B?Y1VJWTZEdWlFWDZ6NXBHN2hBQ0g0RUxxQklxNHdQaFNkR0NIQjVxTjlNbEI1?=
 =?utf-8?B?eXhnZTIwRGF6UlFidmpVVFJtWWlCSDNYQ2VzTm9hTktJclE5US8wT2RvdkVS?=
 =?utf-8?B?YVQvV1MrMEc0czNjUy8yR2s3eWNXSWVHMjIyd3VibGw4WElpQytTQ2pMamNQ?=
 =?utf-8?B?YXBwSU44NGg1TXdFS3RuNmhwbzVSd1VuTmwvR2F4TU9NQTFGWGF4SForbWhP?=
 =?utf-8?B?bXBkUnBZN1pDUjVkVTh5a2VwNjFaOUJXLzdkazVVQzR1Z0x0WTlKRWlHQTRR?=
 =?utf-8?B?QnlxUDRuTy94ZmVLcFVDWHA2TU9KZXNyZC9MdVNxZGZyN0ZlWGNRYzVXRWVt?=
 =?utf-8?B?Y0VBR3VjZmQycE9KQ0lLdEh1VkY3UTB2aGNqbzJXUmtjOExCckw3azVVM2ZP?=
 =?utf-8?B?TDNBNXdKNUQ3K1Y4UFVZb3BWT25PUTdqNGZjMisxQjBRazhBNjhsaDNwU0Y2?=
 =?utf-8?B?ckh2QUl5a1h0QlRRWHpmL21VUHRibDhYT3ZPTjdaMTZQMDdBbFNvdWtQTW5t?=
 =?utf-8?B?MmFHRnhXb2U2R2NtLzBFMXRkSC82VzVGSjFjOTR5b09vVG9naSsvK3g1aEhv?=
 =?utf-8?B?OE0xVnpyYjlJVldRU09tTlBRQVZCa0NQTFNlandiYWVkYXNpcU9RQytSZUJB?=
 =?utf-8?B?bUQyNXl1UXBPT1RyT0RLeHl6WXB2MUJ6Sm5IbkZCK3B0cjYveVpYZFVEVTZU?=
 =?utf-8?B?d0lxQzZkTkh0WGp3NUdSaER6ZHA5NU1sUnpxeU5rNGZGTXIzTVZkaytLY2ty?=
 =?utf-8?B?Q3ZZM3YxOHFLSkNiUHpnbWYzTDJOM2NWb1hmSkFheUEzcU1XNWFOV2ZKRngz?=
 =?utf-8?B?b1NzclBIeWt4UUtBSlZSdDNjL0YrUi9XbTRucTdLaGsvVjVJY1ZpSVUwVkg5?=
 =?utf-8?B?Y2JSOTZBMW5La1RnNkpsY1dBTGRQV3c0YmdIam9ZZVpiVUxjWU5mNTJDK29H?=
 =?utf-8?B?c0VLdnZUcmJzQmo5eVZERTZ4dVVDS0FNWStqdi9wck04Y2YwUURGNGNwQVhs?=
 =?utf-8?B?Z216dXVDcXRrc3AvMzR3MEFqdkpzSGgvb2cweHE4c2FTSDNCU2Y1VWlRV1FB?=
 =?utf-8?Q?O3def67V+CmR/Xb1DO1IyxI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1jx1DlpD8fGFnNdwnvcgyPktCMBGYbdgmXAm7L6xYiG0LcKQw11JFv5IsKa2NB+ykMKJcLbwaRs9VSZfFLR0ET4XOCwiLrHQ85BQWiQt0rCabHXRF9XD61rsbXCDK39rkQJxfDGkJuHg4Cge09p1Ck4aqhbK55Q3UZA2ZNIhsBrPwUx15gSbED1lGV6I4seagWtNss7E2/Xq7hna/9efhv5MCTFB+VYMYDweznwqSZ78OzWynYFq8yumT4MFZ2lbIry/NxZGVAiXVyShDaAZWBIk22R2PBHNPdMIz3/Lbq1f5jSjkfJJPQ9+lefpULE6p4CHPfAAsqP5Vyp0OYnBaZs8c6mWo4U6ZRz5Ndnn667F3bq4neI4wg/NWgamqKvbTn15ZwOngvKwydp0F2qKICkNWFhKnqQq/Pq5MoRllYDIb7TR6H8OaV6KRGfebCrkTzTfJaJmIqoWyGD6gLyWUpFJuVZ4VdTjT4lEMc1U1E3xCebPbYGp/g5fLGwqBuofmGJGiEZar6315smuuwCmbieaNI52Gn4pXMAnyl+UOY+k0wAQtlWLTXqJpxdSQ6BC4mCL6UL12r62EiH95eXYoGHnggZStsESnDVB5jvOttmvugxDMgU5E8OdCBfi3R9Y849ibjpIAJ8YPeZ22mHri/0I34lmhUo+kRqaeIXBGI3vEIOBkpAluivKL6tQT3mFkB3RNYw7XpJXgmVyavHPucGgPAizsOpEhfNnvkUfnZAr2uAaS/AC9sYFpZjJ/h95az8zW3YCoHbBQSKBKVxDVCRXXep7FE3/GUmOOMHCGraRcWRwZE2ozBXnG8otvoqRZyl6K+VL9nzKMkdOlWmNOQIdjzIgwdarXiuBudyQkyvcEfyp89sYDYVyScAahrQEr2tyl0ejiKsP4Xqlw/NpKw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c1f1ff-29da-4678-bd5c-08db10f0d0ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:08.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bmTgIlNJKDJZQX0gL0IGnlbiaB/M0Jgcgjiezjc/NFV6FrBQyFJydiNDXm7OIPBcDSYkIlZVjT27RFZ7+SxRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: YgHKeq9MuA-Vutv2ITDNEq0lwZTd3qPp
X-Proofpoint-GUID: YgHKeq9MuA-Vutv2ITDNEq0lwZTd3qPp
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series, based on current modules-next, is part of a treewide cleanup
suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
files/objects that are not tristate.  Due to recent changes to kbuild, these
uses are now problematic.  See the commit logs for more details.

(The commit log prefixes and Cc lists are automatically determined using
the script mentioned below.  I've eyeballed them, and they seem reasonable:
my apologies if they are not.)

I'll be sending a third 24-patch tranche in a few days if this one
doesn't blow up.

(In total, there are 121 patches in this series.)


The series at a whole can be found here:
  https://github.com/nickalcock/linux module-license

The patch splitter (not for upstreaming!) used to prepare these
commits can be found here:
  https://github.com/nickalcock/linux mass-split

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev
Cc: dmaengine@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-actions@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-gpio@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-tegra@vger.kernel.org

Nick Alcock (24):
  kbuild, soc: fujitsu: remove MODULE_LICENSE in non-modules
  kbuild, PCI: remove MODULE_LICENSE in non-modules
  kbuild, mfd: altera-sysmgr: remove MODULE_LICENSE in non-modules
  kbuild, irqchip/al-fic: remove MODULE_LICENSE in non-modules
  kbuild, cpufreq: amd-pstate: remove MODULE_LICENSE in non-modules
  kbuild, binder: remove MODULE_LICENSE in non-modules
  kbuild, bus: arm-integrator-lm: remove MODULE_LICENSE in non-modules
  kbuild, drivers/perf: remove MODULE_LICENSE in non-modules
  kbuild, ARM: tegra: remove MODULE_LICENSE in non-modules
  kbuild, pinctrl: actions: remove MODULE_LICENSE in non-modules
  kbuild, soc: apple: apple-pmgr-pwrstate: remove MODULE_LICENSE in
    non-modules
  kbuild, soc: sunxi: sram: remove MODULE_LICENSE in non-modules
  kbuild, clk: bm1880: remove MODULE_LICENSE in non-modules
  kbuild, firmware: imx: remove MODULE_LICENSE in non-modules
  kbuild, bus: ixp4xx: remove MODULE_LICENSE in non-modules
  kbuild, irqchip/mvebu-pic: remove MODULE_LICENSE in non-modules
  kbuild, pinctrl: nuvoton: npcm7xx: remove MODULE_LICENSE in
    non-modules
  kbuild, bus: qcom: remove MODULE_LICENSE in non-modules
  kbuild, bus: remove MODULE_LICENSE in non-modules
  kbuild, gpio: remove MODULE_LICENSE in non-modules
  kbuild, serial: remove MODULE_LICENSE in non-modules
  kbuild, dmaengine: s3c24xx: remove MODULE_LICENSE in non-modules
  kbuild, EDAC, altera: remove MODULE_LICENSE in non-modules
  kbuild, power: reset: keystone-reset: remove MODULE_LICENSE in
    non-modules

 drivers/amba/tegra-ahb.c                  | 1 -
 drivers/android/binder.c                  | 1 -
 drivers/bus/arm-integrator-lm.c           | 1 -
 drivers/bus/imx-weim.c                    | 1 -
 drivers/bus/intel-ixp4xx-eb.c             | 1 -
 drivers/bus/qcom-ebi2.c                   | 1 -
 drivers/bus/qcom-ssc-block-bus.c          | 1 -
 drivers/clk/clk-bm1880.c                  | 1 -
 drivers/cpufreq/amd-pstate.c              | 1 -
 drivers/dma/s3c24xx-dma.c                 | 1 -
 drivers/edac/altera_edac.c                | 1 -
 drivers/firmware/imx/imx-scu.c            | 1 -
 drivers/firmware/imx/scu-pd.c             | 1 -
 drivers/gpio/gpio-rda.c                   | 1 -
 drivers/irqchip/irq-al-fic.c              | 1 -
 drivers/irqchip/irq-mvebu-pic.c           | 1 -
 drivers/mfd/altera-sysmgr.c               | 1 -
 drivers/pci/hotplug/acpiphp_core.c        | 1 -
 drivers/perf/apple_m1_cpu_pmu.c           | 1 -
 drivers/pinctrl/actions/pinctrl-s500.c    | 1 -
 drivers/pinctrl/actions/pinctrl-s700.c    | 1 -
 drivers/pinctrl/actions/pinctrl-s900.c    | 1 -
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 1 -
 drivers/power/reset/keystone-reset.c      | 1 -
 drivers/soc/apple/apple-pmgr-pwrstate.c   | 1 -
 drivers/soc/fujitsu/a64fx-diag.c          | 1 -
 drivers/soc/sunxi/sunxi_sram.c            | 1 -
 drivers/tty/serial/rda-uart.c             | 1 -
 28 files changed, 28 deletions(-)

-- 
2.39.1.268.g9de2f9a303

