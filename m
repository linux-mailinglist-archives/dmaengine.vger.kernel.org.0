Return-Path: <dmaengine+bounces-92-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043437EA632
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 23:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F58280EE6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 22:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB32D62D;
	Mon, 13 Nov 2023 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gfGerNs5"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02702D607
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 22:57:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF17D48;
	Mon, 13 Nov 2023 14:57:41 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADBZ168012916;
	Mon, 13 Nov 2023 14:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=wjS2LOtfvZg3o5rztu
	OWpJqWAjJcEDKzav4OGC6tH7E=; b=gfGerNs5oseKDmQA8+9xri17Sja4FMg9YD
	Papq55ijU8AbJ7/Z/1rozITSmgJcvPDQ1GEgqPb5/Dh3ZXrp7xeYAFA1A6tEjVF5
	qDr5pCQF8orJEevJQpyrCVHqKr7KrGbtG0KPA07lVPaogjXv8JQwtclQAirLDmDi
	ZEDQk6LVclY3F9QM9e9st/dUM2Kh3D0B3TfPNqivTPd0L3igzdoWvxTpuSeCenGu
	ZzWNJUItKeL2EvEVmO5O+24EkRjRj6z+eKv4SXEUNwfEmBMe5htLZck7nqtY3coP
	7eZwHLraWn2gQrX3BkhS2HETVOgfrUCkulyHkmBQ/uNVaDaWZKqA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ua5s4sw6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 14:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCtSwnB2d7Hwe7BbvTROsW0L1hRBSbgay4keepbybPvlqHaGI579edCoFd+3MquIQqaINMIGrqqSHsNbVhXcmPGwAhQs3GCeKcmoqZX2XkZgV4OROYDZBZJ1XJPxfqCFuWfv3C7T9Z2NXDuN68qPwR3a1t7D/jN5dJo22qQZ9UvYWkl+nRjkLLuwa00RZnqDeU9Czu6TIrfaU6X3OXpAbl4KM9ZOXTxgv8ZJ9LpAH3Adobdf09WSrR1z60w3RLYmtiCVw5jT3x69sh11Ul7UJ+WB7bEFIEpaEWDJ6bfcO6b0w13wC7Y9qu4n+jlBEPPoVR0YzPJnpdIMN3gEN5wmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjS2LOtfvZg3o5rztuOWpJqWAjJcEDKzav4OGC6tH7E=;
 b=ftGiLAauAsJlsz0sbiY8JBtlOH4ulz0C1cMjbNb2unDzk1QMwHhslUlZsrzgm/jKptTZB2x/6j0+J8BcNz2vZimL4ZRg68ZnaCBVdYbjAgWhq7IYbnvvXNNNfTVqDGFxdncNTdsApZQO6H0rOMxTCgU2PkGfOpepiggUeaeCCV81DwjDFXiJBqkWhdx/AcAddC0hCKYnzy+yVk1VqyVyc5cqNujYgtb8Mt/Lwkq1exWlFrAxVAJOJvlvEiBBSG7KmLaE4xxdWDjDUPmtJMH8sI0EW4yxl/zYwPZzAJfRU4o5wt4BcfR/YJJSvTMkj6mTrQ7sS3xVG9E8gdXbDTQFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 22:57:30 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 22:57:29 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: Frank.Li@nxp.com, vkoul@kernel.org
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix two exceptions after the introduction of edma v3 
Date: Tue, 14 Nov 2023 06:57:11 +0800
Message-Id: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::29) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9ec161-a047-4846-3f59-08dbe49be9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SE3NUUO/hRKa9rTw4EeIzB5bUP5/lFBEbmnwikyMBCpm3bdwcWqMV/KQYaZYBO5ZRYHVwhAMF5HWU5PEFpi8otYCGfSqzhrdkbvIKx5GiaDPlmgBJThutSnsvzbY8u2D9/bnq4IQTgj+vGkfh3y5Sd1zTDv2pkUBQcHG8+PAL2z3hPz6qiILm8jGFbg5nnghdMlhNXTrOOl5TNWv9G+3cJ0ZPfR0lrY0TKo9ZT81+cUNCOHljSsrBZP14tgr59MnRtJ7J2DgHgev2bTsDHrsvns6ul1cuoyFdYZRK68RWd1/sRjSmfp49gb3snbc3bP1Xpo5MB9c6I4F5xgORbX+ZH3/ooENolGJkpkDsm7wYfWLTqYprzQFb2bFadDOFBG8Fe7LG20yyeGtqcQ/61Z7qDSgbuXmmHGXRiPcMClYc3ws2ypx+b1phA01i81thSaDXBqa2xeTO4Emu6bpoB0dG5oMPE9LSOCa3OkiTV9yBhtrf5ZdMV3shjIdyB+9XYJ7gjBERbofQzUwhJUsg4Byc8SF7uXgHRYA/wmVhfDZvdZ9FrYY7PGMYqeg/KQ39DLCX466uSwEvqY+uJsj4AY2AVLF+2Cv53+iwbURVPBdoKaz+PHvhfcagUELkYiXegVy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39850400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(2616005)(1076003)(8936002)(8676002)(4326008)(44832011)(52116002)(6512007)(6506007)(83380400001)(26005)(4743002)(6486002)(6666004)(478600001)(66946007)(66476007)(66556008)(316002)(38350700005)(36756003)(41300700001)(2906002)(86362001)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JoWiyCsLSwklfG501ADKiKKvUBThwcdu72X3lmJc2d/CyDOjQaYMJVM3VLzz?=
 =?us-ascii?Q?y64uknJ3aqh+XPn35hIeZxqQurM2aSzpl37PtP6r0v/LgJwc+CBZLNqPkj4U?=
 =?us-ascii?Q?V2TX8tm2jhuYi71ByZnJ0PkHl61QhRXLapQjOIqUADq2CdWcgH259b1TpvbW?=
 =?us-ascii?Q?Mpi8UnY7rl+XDs6Ue908D1fHgbs1qIk8efDQcZwqMAewAwHKJWil3+IqK1NB?=
 =?us-ascii?Q?2elFv4PDUeD1/LgF6KvEdc/OvoO5/yqD3i/VYdNiO84j06SdHQSt3P9kJs0y?=
 =?us-ascii?Q?kdOQaZuBDIRYgFR04mwRDn4N7wX1VOcsYvyRysVgNipwYlxruQwHC0iMNd8V?=
 =?us-ascii?Q?pJyfNe/qi3MmdF1ye8uepzVXkeNKPYqJSHaSf6gdN7M9icVm5h5vBSTUBPcw?=
 =?us-ascii?Q?NAC5bIPqLAxcVBY6C3eGvhH0fCBAx54Wz7P3HiNCk0NgnwFq6OgJNebI8W7B?=
 =?us-ascii?Q?9s7TSk6obWtjGTdzPhFZtYSMc1uFGq1fcLj02u2LBC1bgUs/ADQWyVRWMU4K?=
 =?us-ascii?Q?plrlBQchol1pDck14P7uFY6PyDCg+JLNzbu/ZxPGf1oIVFVdoPrKhXG40OoX?=
 =?us-ascii?Q?bX0lLYlYnzT0vvIcPyRpJgORRSOBQRo2pvRE9eYefxtAO9r+OsW0sky0WCMc?=
 =?us-ascii?Q?pNBnsnta3TamyzXcrG4FJGjutbxB7qG/3EFEvq5Q2VGViN/GFQGPuEhbW//s?=
 =?us-ascii?Q?+6Y1fLJJcfj7ZHlFApap4b4fgetmOMXrCm14Q1+MiV5EZPlF341J/e6dxS3k?=
 =?us-ascii?Q?VS+PZ30QqUf9DzKUCV7U+CrVUgvHjOzz8NL3iFNnlbEcw597ecd2d1lhCpBG?=
 =?us-ascii?Q?xtqoSBiAwYAMdG+OMVR6M0imlk0HjJ44qlYVImov9pfoEV+tpjA62LQbX5Bv?=
 =?us-ascii?Q?Xshondc7M0lwu82PQbnphUPWVHIZ3P8E+mgYawertf5DFm0GybxMtE48K95a?=
 =?us-ascii?Q?9s2CU2TD9La0XaSLr5NANcbIsJ00axoVlshJfW3CjjVLYHHKh0D+d0xvOPde?=
 =?us-ascii?Q?quTH8Cmy4WbCVrmMzQp71f4FSguMKyuThY6j0HdOujb+pxrnwZbwyqhz4+rd?=
 =?us-ascii?Q?EgSDqAJ2svCim8uIA5z1TIl5EqDOg+TtSfAfznbT1WkKx1a1DgKPn5LLMdzj?=
 =?us-ascii?Q?JsjjiTT7HJPRWbpgn+zuwx9VyKazuI7BcGYrs7kLpINkrZ+zzOMCbHDBvslP?=
 =?us-ascii?Q?9PJig/eKQFd5Wx1KE3pXG0MfaKwiPvEv4NX87xr1CzCrtsbw9wRrZv7gcRwO?=
 =?us-ascii?Q?q1ipzxarhb4Ely+mgMB/38Q/GGvnRrZlDoVhLePVAY3uuwFXlRnf5VcLAqJ5?=
 =?us-ascii?Q?aohy1V1zweiy7Esh9SL2VPTllUfXPOVrRdQxYl2AayHd5KooWi/fam68KFt3?=
 =?us-ascii?Q?z3Xv9xThoZuDic6+gA2ZJ3UD0hF5p6kIL5iF7R3H8dL1nZMb3h1Ub1pGoD0W?=
 =?us-ascii?Q?ss7HR7ObAXBt4tAc9l8hicP/1i4v/xrwmNb/LI2zh7TIEUy2He5cWP1AWwUy?=
 =?us-ascii?Q?KMlhYw5RwmM/MSMl+4xiZnhylrM4Dt3bDs6Hav2PUyIB0n0+JpLUjF2P9gsQ?=
 =?us-ascii?Q?hsSXBawsTgUtm2w1Mm/WEo1QbPrEn+LPXzZjOH2DSO3pbXrEhJXNh/7bgEkT?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9ec161-a047-4846-3f59-08dbe49be9b0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:57:29.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1p3m7RTQiDtYHsb0278J+8nnZrMC4OukUCUdeYTN1PciIDbk53nBu3u5MnEBvdiqhFWuvd6XdISpXtfdhYuZT9cfgz2hvEd+44ooGs7ieM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-Proofpoint-GUID: QJJZc1Rk_hW7yfdesJ-AygfsU_jOhgfq
X-Proofpoint-ORIG-GUID: QJJZc1Rk_hW7yfdesJ-AygfsU_jOhgfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=664 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311130179

In the v2 version, I updated the commit that introduced these two issues.

Xiaolei Wang (2):
  dmaengine: fsl-edma: Do not suspend and resume the masked dma channel
    when the system is sleeping
  dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

 drivers/dma/fsl-edma-main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1


