Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3569F5E6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBVNuV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Feb 2023 08:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjBVNuU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Feb 2023 08:50:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D52799C;
        Wed, 22 Feb 2023 05:50:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xHwc002711;
        Wed, 22 Feb 2023 12:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=O/CBxGNxjrJ28ER7IiPoe7hFsN+PlSY+oTxoRb0xqZw=;
 b=bLq8Unt+t3Azr/YGwurZofxi5sbzVczKlWwFZBs37XVCI+6JyMu0GU8JSS/mzxl5wbOq
 1sgeD8kOCUnPG6zoPUmucmxruRuAR1TcDaaIiaHLkgAtwSk7XG2pSmpEhGHD8yA5miE+
 S/aIXhd/q3Gu9GiHilKtcWbzxHk17nMdFvn40mplOMT88pwQ1DtXMg+1SE4/08mFkhPp
 KJxcziRCwzLJrvik0ylXRn/HNP8SH1PDviASI0yD7HShlDt3jG51JyuppsBfw5SjOeHO
 xW52zqVMXCHTG8+T6xfq3Zl4yd8GIeP+zb9Dc0atn5QXPdq9xNi/9Ab62DVP+r2Cr4xh 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja7n9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBsT9t031257;
        Wed, 22 Feb 2023 12:16:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fm7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI7BDkwP4KRu917R41MNn/nfd4BqM52be/XBD82rWDBhfLRSgTfqH0Hb2P/PB/1CMjZ5YN/IbuIAXrBsD8K5paAiXGBpsxlpAfE2A0Ur29Yruax9Zdbp+YmVkZR6osxZmaCHDE0R/aFvVuaqq3pRmq6XxJtb1AMdM5yXZ7ByQ+SaJG3JGuQdsxRMyzVEGfj/Hd9fEmBjyUHNCyJdwJYHRs8pBD2s3+CXQ7YUfMJD44tzlwukCTaTdUdR76z9l3RFja/xJ9yuu2Ur9Eh/z9Bw4pLM0kVO2iEgM8iXSTKPYqNObmIj57A9LeZcyHmtg9B0CC1mS87tZv3r3ddJoPULbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/CBxGNxjrJ28ER7IiPoe7hFsN+PlSY+oTxoRb0xqZw=;
 b=ay/jx6VW/Pb7PCy0p08APsfmSRSfNk8vN1X2haYPEIzTFufOZ00lfPmVa35kOKuthEPE3H3a+3BQjOG76w/ipoMIJgSifGWVVWE0nLw6FIIn8pbsTgaZnpo8yArRmSpetx6t5hKC3BvY5wGr09rpl42AB/f0gpdiPPGhUGhkS3fyMTQw5qcVWjtTmIAKuzeDczCu0MlzTIv929x7lbHlH4dXgWT5GgjWKNOtbYK6CzMb41B+C+c93WWGWn3XjjLJVWszHGkIFojt9OCphIMho9ZodFOd0TPDFEAlsg17gj3LwJO15k+p4mFxE8RKlQRD6oJ3DZDkW43fOx80mCiZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/CBxGNxjrJ28ER7IiPoe7hFsN+PlSY+oTxoRb0xqZw=;
 b=W1fMY/0XQL6bBIOuQPiQ8qZUXb33CXEE1e0kZU2331Bp/9uQrBFWir+1hHvh8ky7S+GTZGLJNt5L+3FRl0AA+/9duimSiblenXFC6zZWEsPqS/ERbP57U8Y0t61EYdk+3tOEn2seeTbaOE5s9GC+Ug4Wn2CPmIi8clV3CtnxGnc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/27] kbuild, dmaengine: stm32-mdma: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:45 +0000
Message-Id: <20230222121453.91915-20-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b8f96f-091c-4b0f-6c6b-08db14cea0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cs8UT9AyqbVg1I6C0fXWHHqpoX6qPY2BBLGws94FIehm1Xxe0ghj8j1K9enLXXs4nND24Vnc4gAfwgE1/EBY2Xh9DglJp1RiMbaMhvouYJeTLPBE0mJQ8vW7V8/o3s7NEIvmZawoR8kQ+Hda+xn8POhzshauHkF3oFHCTaXh6g+PpJITu67ruBfAjrhsLterq/E5U3uCH4PLu9GQwm6Bz3gTutkSYBW4wTpbCDQMQ5CcE+y7ZSDnGP/cFFJpjZHHokjImVZx/fGL4uHPH5fJnIXGgjjqeGTIfS8qQ0O16htOM8OYJ0J0qMbrKKcOh0UKylLF0xeFYGtas8Qel3HVpvReliHizBTCOPBuU2qMoC2GBekVZbzALEcGRtA93rH+SPd09OJyrL6cg+dewyhoLBBsfU68M9+Tn/+/INL6YSElBZZy59VtDhRhn24iCHdrfOLS82x9quSgLRfwH1EXL4h7zAjkzQ0Nv6BE+sO7SvD0NdyAjEpvJqKf3LHd983SXnpP1lD4swbRjTYcNzRz2OP6Yqt9quAMs/fdPy6+vnW80kii8teve8wXyqkYIvrPZtVAvU9pMgThzmS3jIxznRFiC2t0PECqkBJDPaA33gGWkT3xNAnSokWc1EKkorXChtpQ4yDc2ljbpP2a87ku7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(7416002)(36756003)(5660300002)(44832011)(83380400001)(2616005)(66574015)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+DLw9vc6Z+eDbvy1PxBKdiG6zaz0EHYk77MOJ5T6WrYQKrNU9hIw7YDLADa?=
 =?us-ascii?Q?Jg7kbuMsgDKcVqYRGftxiBQCuN4Wm5iK28C/veZq98L71X3f6IjcQqWm5HRt?=
 =?us-ascii?Q?PQRFCrxJDhShOE2EEoVMVicV5/0f2op88fdw2sQJY6x7h09Pgq76xbtw/frG?=
 =?us-ascii?Q?T1Vd7muNPwimtC8aB2axL7AVXamYKvXF6RYbi7Alzu2rMozWqEzia90eD8ij?=
 =?us-ascii?Q?7YWfawAXaQlBNoJzEetki4xY+2TrTVdd7kYZjkfmQXMewoeBuRv6lkvVWnKQ?=
 =?us-ascii?Q?I4THe4Do+HIdY8ET77sAlmgGUWfIVmpia2tWtAn60b2PZ/xmcQEb7/NGHi3h?=
 =?us-ascii?Q?Gosq7c2WbxZJmH4/2FZRhsOl2F9AAwDNT71YlL5vTYy9C5jxBE780YO6f+5x?=
 =?us-ascii?Q?C4wE3AXoLIe5zHWXhwI7CNiW6iIILR0B9gn/GQriUKmUCc4Lxs2ouXZEP8hF?=
 =?us-ascii?Q?OpIY3GYiCO1QHjhh+wOf22j3IcgdROKVuPBly1dX/Lt22AvQqOfpY9yqXobu?=
 =?us-ascii?Q?1WfP7g3xDN3dABkxmWFC3e/rHH7L5Ol0oPDT1jBMgeRYwBOkPlWHWu00tiKe?=
 =?us-ascii?Q?j2D14Wa4ZY3EEViELc+M6PguQAb0tYU83Fo02ObJ5qORLksVJ6MKUjOqrFr/?=
 =?us-ascii?Q?EB3WwbNicrZ80xKwvPoP89gJcIg5Qy24Wm6h4Ke8z5LSFgyHvbpjtt/kkqo5?=
 =?us-ascii?Q?v0dLnM5AB4iQlM5QOr2YC/uqfd8EF+0rEzFEvhQCHhxjYHVUn40ka/kZ+hIH?=
 =?us-ascii?Q?8P9r37vUuhA/+5UVx8DKw1dduH26MOXOzJbPOpduJA6SIXw4ouI6V1cDfFM1?=
 =?us-ascii?Q?miWHFskLjEx9WIs0xadtdAksHVOyOzo3EAE978robp6USQP95Nhw9xCdEDbw?=
 =?us-ascii?Q?lNNvzzdUsSw8YFTzRre1lcYDRtB/DDFC79mZbCcmIJRDiOz/eiiZ5d6Oy3De?=
 =?us-ascii?Q?7J3w6348nAuh0MNN0LRvGqAIkfb7WgqA/NGIt56qgQlnAgIj9lboQqxBVbgw?=
 =?us-ascii?Q?4vGXankBTUnEV4NnkKaKxHYZsdU2cKVAyWNLNkL2i8upxkdUFIuUEmkpvM+e?=
 =?us-ascii?Q?0xzYDzFuzv/EgNioN43Dxtz6R/4b9JVrRxKUMO2JGIvL7ALgpaQgd2Mw0ibj?=
 =?us-ascii?Q?+c4Y1LgS236hKv2upW9WMGCOzI7QyUJRYcqYamuB1nk6xrS+5E2y0AN+9k8w?=
 =?us-ascii?Q?yPwQJN+G9k86RoK4S/zs6x1cFD4+Ifo+Z1CO3lT9vTfKZGSyoYTGJ9GJXeH4?=
 =?us-ascii?Q?BMLtxMmOkHsOw0dH/4AzguQpxzjg41AJkmGT5NZftXPAa/lCEnBy6ntU2joL?=
 =?us-ascii?Q?2U7lsqZ6VkX18Hw70u9O1gAmuJwoytSmhg+oIXsYq92tlx4Nhc+WdTAw7390?=
 =?us-ascii?Q?FApWJ6/spDBvxx8o+UeSkBLvOfkhBabHntwGDjCAmcWmTZgZyH3G7wl+oskS?=
 =?us-ascii?Q?JsN2vshzzQlPwPgM4gVWj1v/Lh0Ht+TCDN4DsinC7oFYc1XjUQfypZR99rdK?=
 =?us-ascii?Q?+XzVTNBHzPNOkhhFF6fTzOqFIJ2PVdOhlHOgyQlnBOnuIsyUhlV9eH4Bvt5C?=
 =?us-ascii?Q?HVCMIFQ2LWBP3UljZJDRaNYDCvTc9QVJKROzeFUNlY44JY0DAE1ImktPbP05?=
 =?us-ascii?Q?IfPvW7MrWDxy0c/DyqCdvIc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xlESeX/vMrnuZTYWJhBWp8glY99j64AxQlyrdv7JU5zwv/G7KcY8LNF+9fat?=
 =?us-ascii?Q?UpCTXUe7TSgb84E+2VwhvmgLLWgFFboH3R7ncBZWz8zb461UWKBkM+1Nmjtt?=
 =?us-ascii?Q?uznPNTSycagOJOunpxCfEi/VnHSNNGvNa2Y7yWHAcE90b6NLYaTqAuUp2oxC?=
 =?us-ascii?Q?SouDhFIRdmM5IykI1eGXWrw3Za8rtiJJm/fSdVm6pGao04IeagvMh65xy1qQ?=
 =?us-ascii?Q?gtphWrTXnaiWrA6SvCH6qNU2FTTjwoLTbVTrVKgZ4PPbKFm+4C57llVCZF3R?=
 =?us-ascii?Q?3qqLUoIIlAS7ROwrSP55Vq0yPg0CIDG7B1WQcaMbkPv+82or+L5+8Gcl/1rs?=
 =?us-ascii?Q?NaC9tUfzlvOD/JscVqGs1w0UmPvVzsByMwq6TBCIupOT0Ao084xxkrjFS4Sy?=
 =?us-ascii?Q?Vsu8nMW9PqTV5yWHCj7CdiaYRKTClkRQccOCjh91HQSO5+/lIjEwMGxzH6bw?=
 =?us-ascii?Q?v+z4Mmj7EdrgseNoouVSP+2Es3DCpufT18o/xcj6V9Oi/nNKoRNg+SqiM0ol?=
 =?us-ascii?Q?DdqScgIaNPju+N1Z88l86HFN/ZH5tmSos0txRsVdPScy1nkQau+bx/1rF5XO?=
 =?us-ascii?Q?7wgP84qAtmTrRJDMGHetvKFKd40is+AoOKl/OaMeEBgSSZEsYVaO6l3OVlS+?=
 =?us-ascii?Q?8DPnE+Jpx85AYcG7iq9UNUg5T2bYzeTV1kChDO6Ez5F0dWFZAWR+ZJGdEhjt?=
 =?us-ascii?Q?LmSXN0hocTZo9ts7Cpk5/OxpbZFUi6qUIIN+WX7JNHE9P2lO/VRzt6ZigEvX?=
 =?us-ascii?Q?X/UP3uKmEWbyz0baaQhVjcKLrumWVuzNM+IX/pYJNzZ/oGYRZpY3fHdvbi8X?=
 =?us-ascii?Q?5WwY4notE/wUyNYZrmxgebnaE7wFKyHVYppkdp56wRjVEcbLMvMVYlGLfhw9?=
 =?us-ascii?Q?OtvpEKTYVWPQFbvOItKf+FKB0fPAiixBjueVPsDMfwGK6CocdZTzOTL0OA7L?=
 =?us-ascii?Q?o1lhtttSNlxUq1nYQxqxQKcg0XiRAzoOYH7tmqT3Sezbeo4PuHFOQifTnGsW?=
 =?us-ascii?Q?luFU2VHgXNqfzbMzeXm+htUf3mgaFNSBV4jxVWW8FgP0O2w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b8f96f-091c-4b0f-6c6b-08db14cea0d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:29.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnPL5uSBhRnvydSVvHXRndzErQn0gGHTAzRc3kF97oi9QkYHXZGtpiNX6Ri/mepB4EHgxd54r4tIsGk9AShEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: dE_XMB-8T0lskgvGwdAPCNJ-N3UCIB2O
X-Proofpoint-GUID: dE_XMB-8T0lskgvGwdAPCNJ-N3UCIB2O
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dmaengine@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/dma/stm32-dmamux.c | 1 -
 drivers/dma/stm32-mdma.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index ee3cbbf51006..8d8bb6770cc2 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -400,4 +400,3 @@ arch_initcall(stm32_dmamux_init);
 MODULE_DESCRIPTION("DMA Router driver for STM32 DMA MUX");
 MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
 MODULE_AUTHOR("Pierre-Yves Mordret <pierre-yves.mordret@st.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index b9d4c843635f..3f2e7a55cd03 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1816,4 +1816,3 @@ subsys_initcall(stm32_mdma_init);
 MODULE_DESCRIPTION("Driver for STM32 MDMA controller");
 MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
 MODULE_AUTHOR("Pierre-Yves Mordret <pierre-yves.mordret@st.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

