Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA069F45A
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjBVMTC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Feb 2023 07:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjBVMTB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Feb 2023 07:19:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0E311F5;
        Wed, 22 Feb 2023 04:18:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xI1s002850;
        Wed, 22 Feb 2023 12:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/uYCaNM4Qy16wWAWAlH6XbdxDrO6v1SBJDJyArU079s=;
 b=mB/A+RKsN/MzNNhA9XSHchf1lYEHKTGxECN95WtWbNOXgJpsIEAJNbV3YdDIul3wx/CK
 b05EVj4A5wMf3meezett8EaTNbsQFli3mJmp+uze6k30swcMLPaqVOEJrBBKMdNQBGPJ
 ERpz099jQirnFC0t1uKMgA1m+FLyDCLDLVdxhKcuQOstWuebkPU2HX7TtlDBEL7jmNzg
 tOYucc+O7eUodIlrTKa9jMOhDW1knf4+eDtQdZXaggPJ9otvDl6Wh4aTQOSvrKPsaIGh
 es0Efo7UT17wvyxHhou/ZrOrvd7xfniNqiqF+tP3xa7Vy/A3g/nJ6YKNb1ZOzgzixMFK EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja7n9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MAdVh5031252;
        Wed, 22 Feb 2023 12:16:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fm9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keUIIV8opDYi0Mw20gyA5XtlfZVQ0lSDiEiZu1ysLkvURVHQzGFGVcB5C2Y4gk93PvWdLbzN7vJp40iDdbVlRkzXM+frchHNDgPMjfzNN7XOt3wFPH1RzqEQb0701bUtJjd/S1Ho1bOIhhFC1nLG1irEMn2V7yOd5Mf5hrnuQAIv3jEmAsR0dq11HvyeRrJy5RwxDTPT8gjR9bXF328xX1OX7nsVqqhOc6QZhIniM2SbqTgvt7L/I+9gOmGIbwhxll8voe2pAOc3uIyoNNuJmIt0CFr12wAUGjaxjMmn8QsZEp2qkfeFUaWGLWA+vtwJC59nt9bXMuPh1SBHJYfMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uYCaNM4Qy16wWAWAlH6XbdxDrO6v1SBJDJyArU079s=;
 b=d49U7Gv3UizUSted6x7UC4f88vv/m8jZv7NJCpYkiNx+7XBDygmE40M4Ktf3Ss5070itd7UIi7e3DHXwhqnFeYqNUK3mp05ivoo9h29mCS97G7r3z3Lz7EUoffW0MiRA1TFmW4pikv/nqyAIa47w0GGqsXogpszeDklLx9N6z49F9P8YKK0h0srtOJuaCb4jvirkyMsU9C7AfGQzw2/4ss+VPgxNdriBdAexE5xs3Dj5ta6gMMY4XbADX/m6z83CTKLkv2got8Bn6gKowaf+ipWymLtZIY77sGz6ZpZhBzfZXvlDPxXdmdfqqQyOktUtUbBTZ1EpRwdXxxayqvEDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uYCaNM4Qy16wWAWAlH6XbdxDrO6v1SBJDJyArU079s=;
 b=atrl9sM1P0dBxI3ZdUIvtFOpn59HEJWenzg99FVRxUKOipQaae4NqVtILA4/RvHgyWutBYCZxV3SS6z+F4QhXMmDRhqiXxcWEfbsx7hMwuSVzeu38Ohfukd9aTxZzITGpRbsB8N0ieJWIDNFQdk1Wh1iN14qOQZGaVPwfJlN6dg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:35 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:34 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH 20/27] kbuild, dmaengine: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:46 +0000
Message-Id: <20230222121453.91915-21-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0397.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::25) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: f84dce2a-89de-4186-6b0e-08db14cea3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g6/80ETeR5gAy1J1G9tQukteUkWEAT+O8DxaMpqKvaILKHOtbYw19cQZZ0+28yeig679rTe733nW1RiiFBxZHz6MH+JRfNTzens2155E+17zmNORp29nfzWq/SOcNS2XZde47ZnNf6VBXp6UvSbYq0LHUZyWS2neqnLjeJ//6WWrpHS7qbY27MQqKWqI3FNltCJvNDuQP8Xl1I8T4ZP4NFMp3a1LeK9ZoMgp5e871+O+lSWUFuZN/r9QQtuoaArUgbKwHnK3Zj2Q/TdJ21RIz+pgveaHHw1NdLhB/MrFlhtvfd8RI716ZyJeKjotZ/2zANE0HfcgxU4OpJmIRjW3S+yC9IvvxdnQDOMysVoMCjtahICdqeiOSzEZFJeSuRuNpzNudN+TGZX3PS19j1fXkTwDZ/q/v2IMo/61yh0nctOXQ1MQh0/M5rF20UNmdf0ds1sCtZjybv81vtXh6+4N7PrmHE/GxpSDoOitO5Q8dz1PI8wOmGqsEsvlwoBBAgrQhUC4/8bux2/5TvX4tuTCPZg59TZPDNFWXI1Fruxz2yqVzL19Ew21mk52OSjbbZNxe7/D4f6P+ezYDrRjwET+mYYg7kbw/65uq/C7+szNm2C34B4b9GDd4QJ9w8ZXuOZoc5qEqSgUu2/1c0H2t99Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCJo+BBS1ElLtzNk3IlpvLU3N8YC4yka1Qc3gboLAL2dh9sZrXqH7on/xaoa?=
 =?us-ascii?Q?KI6dRezKb2vGOxByExHBriIhr1wU7xRj689nUXcLThXIHDM1MpXhE9YCBk4e?=
 =?us-ascii?Q?McaM69U4EV0ptaauCRpvfb2cqCHoZd1JKswDJIOgC0B0UcY8MLvwLtinqwNF?=
 =?us-ascii?Q?RX7cHFhXdlgts1Qdz2S45ZHZii4oVSebIZEYaPEjmiHcdltp8vQaD5E9Y4x+?=
 =?us-ascii?Q?PlpINqIZKOG8Co7Vh/va/rv8HHFjReHwCDHluPdnUoQcnByT9ogLvDamKaKl?=
 =?us-ascii?Q?KlA7S7rdQvXHlDolUmXZ7DUZQOL/XFqoYzBChMDOXBG5aGXK+8AcO+JvVsMk?=
 =?us-ascii?Q?QGq1IY0jJJzW/lhJ3kRZFWcjG8heyXfk5MXq4LfHidoEnhS1/zxBjxd1MkAE?=
 =?us-ascii?Q?uwNrr/4LXWXND94ADdPNjdKq9sQEHrkjOjMyx5fv5F/ggShH92ngaxDNFnfo?=
 =?us-ascii?Q?cPEcejLqpjbTjG5ZVSHJsK+oL7TydK0LHvohZijiLI7b233Jkyu+tQ5Yeka+?=
 =?us-ascii?Q?hOKnKMwjZi+KITv29Z6xK8EolMPX4OsSHrku+wpvKNrw8hrFQkGdwOLLnsSl?=
 =?us-ascii?Q?onhYUE5kzgHIimnskbQSPtiGdH0zKdHxcRocOdgbssgydW757NEcjvmG0QRr?=
 =?us-ascii?Q?zIqN17gKIxED4Etyq6SlKsHqmagwn2YyEHBCOttjJrrUY5WVy/POjodebEQ5?=
 =?us-ascii?Q?vG50mdJRLhcyoPdfKZj8kQ6oRzKhF8Zn9txYUGOSfVn/H/k86j8BFB9WNIEi?=
 =?us-ascii?Q?RVsDbfBfQadkFG1TdZQFECf8i9AAQ1DVQZmg6/sjTwmnC+gMRNwRpxZfWKlq?=
 =?us-ascii?Q?nvY4eA0KXVZBRjaTyjvxg3EqEM9ywovykEgR4xGvpUEBP0Yu5M/3yISgWGAJ?=
 =?us-ascii?Q?lRFvJBsuh/r0QdmbJRjwMhqBi7uMvfcpURVCY3t0Fv3Diu+1yFGdzk4/SQQf?=
 =?us-ascii?Q?Fr+qO+CeVLdoPyCuVpUDOOxpK4pkil/3IiBOI8SuSTJ21qunP+rAxBs9RyAZ?=
 =?us-ascii?Q?mO+VxHpACV3lYqUkCGJAGdjko+qEWVCv3EYarMsm+1BW0jCnnDfamU/xsTrB?=
 =?us-ascii?Q?U8EXKlZF7sb5vgjUz+N+0QAqe1q3rcLHBfB9hmzUu/t/FHf0dPOOYsjqBro6?=
 =?us-ascii?Q?BZC0CSJWLEyx7kgWi/qBCt3mQLske4Q+tb/VzVpoe9nGSQyan/t5ZYc7rPkn?=
 =?us-ascii?Q?Jc+bC3g/IcWtJ3zRUjy7qZqAQ5ny9QJwhlcDnPHH29zxnK1oZgiS26BcyI8O?=
 =?us-ascii?Q?mw3znKvg7lsEqBPE4057ytXk2JJLghJjfyftooNIxNPy48MC6RnED9X/UDfj?=
 =?us-ascii?Q?qX8ifJPn/BpiJt4JlAQZTmV2UBz739eoA5U9YbTQxbnBiD7u8SvjDbocrebY?=
 =?us-ascii?Q?BMYGQYX0kMN6d5TwAILceVkzP491LcqsImHg9JNuLK1rkrtef5p/RXdZuH2I?=
 =?us-ascii?Q?xptLJO1nGrTPctb18wpbkCE8AapsI6XTEcl3gSPO7BiI+kLYZDV0TbQW/MqG?=
 =?us-ascii?Q?l5xwygt/dxW803H1ZuG1Df91iz0HFKUhIGvmtqUWzTZe0POKhtGWnTYKqTSj?=
 =?us-ascii?Q?R9WsuPUM/KrhpasUUvSh8OJX3G64IQINw4Ad2NhrcjyABzDt4TLJkhO0C0Jj?=
 =?us-ascii?Q?+V0im6X7cNCdSECdpX2CwvM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NhPgFJCs+oEkSnGHmeC42rRM8thlR+nBiZDEf9B+IVCM4EvdQqryDXTBk13arg6b7DkoD3gIoPRaUs7de2jxBY65mBhzTaDSvWAXLMnWI0oibpDdl5mRqUw5PmOp+3aRk0EIyxnoJVwQUJBeN7Y1KsBDnFs/1/ML4T5DurUKR08tnqI0/fBoOnBRzm9tRJE3IdH02KjG3hvKxSaAcZarBCfjN5fXPuVE1h7e7MrXWjCjTfJwtY78SuJKmZoDWcvXWakdsUwt2tVm8Jpqtgz1upseQKv3YDq0LwOSTwbqbz1vNr/N9IXl2iJb9Uh+XcJd2UxPeaz8eOl/1xfUgEDOV5fx97sZ2I/J2r+nrApi4i/4IIJMF2keCPL9JVBgVJEc8EQ/h3Wy4eakFAgO7fSHa+4iVPBGirgeppC/Q3M2HI6lLSsPSXDR3IAHGe5Ky6YhpCipiOAoqsux1RvxI+SnCOmsnT/lKwb9mBowmyn0iQIm+g7rw3zStzzTcdyX6ib5dW36v7d96C6BPDG03Sapu8QPpUwfxIPqCmkxR1+hC8ejhaKt5lI5GVioZXbANf7xGgcEoH7qbLwioTrMZZyQW/+5I/6BPUeB8cqnLVwpbSWNhSQ3Gh9HtOWRW2Pb0Tfw/xhwwws1m8DbLDH8YwodxPtcQqZluE2wyLGmp5ZJdEufV7fgPBvWgQNAu4kBUsx+N73RWFRC7iQsZkVuYICSsLD1PBejeZ/ZNxI1d2sgtR84BRaspmmWj1PX22q5jVLPpnq6adGaC9ALdkpBxjKDK77qQcNVTAXi7cnfsd6tedma4t8nbi9UyopTQsXKpDrKJKVqmERaHFLr5KK4eUXKNw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84dce2a-89de-4186-6b0e-08db14cea3c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:34.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEJyVz2TCqrOl/IiTtDuVkzNGNtZlkNraN/BqIXpZyuHb64nHRGkcBWDHHDK3GQZezQkqLt50+hxjkt6BLmPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: qZV6mT0DTvbdTTjuRd9_nPEsrghk7ZJU
X-Proofpoint-GUID: qZV6mT0DTvbdTTjuRd9_nPEsrghk7ZJU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/ep93xx_dma.c    | 1 -
 drivers/dma/ipu/ipu_idmac.c | 1 -
 drivers/dma/mv_xor_v2.c     | 1 -
 drivers/dma/sh/shdma-base.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d19ea885c63e..5338a94f1a69 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1431,4 +1431,3 @@ subsys_initcall(ep93xx_dma_module_init);
 
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
 MODULE_DESCRIPTION("EP93xx DMA driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index baab1ca9f621..d799b99c18bd 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1797,6 +1797,5 @@ static int __init ipu_init(void)
 subsys_initcall(ipu_init);
 
 MODULE_DESCRIPTION("IPU core driver");
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Guennadi Liakhovetski <lg@denx.de>");
 MODULE_ALIAS("platform:ipu-core");
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 113834e1167b..22f485465951 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -920,4 +920,3 @@ static struct platform_driver mv_xor_v2_driver = {
 module_platform_driver(mv_xor_v2_driver);
 
 MODULE_DESCRIPTION("DMA engine driver for Marvell's Version 2 of XOR engine");
-MODULE_LICENSE("GPL");
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 158e5e7defae..588c5f409a80 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -1047,6 +1047,5 @@ static void __exit shdma_exit(void)
 }
 module_exit(shdma_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("SH-DMA driver base library");
 MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
-- 
2.39.1.268.g9de2f9a303

