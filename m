Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8A69ADA8
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBQOOX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBQOOV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 09:14:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6806C009;
        Fri, 17 Feb 2023 06:13:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iKOQ001690;
        Fri, 17 Feb 2023 14:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=LhahvLgT/JAHXU5J7F1D7UmckdyQvrSSrMy0xssoq1g=;
 b=a49MC10V3Gp9lBFEYrYAqRl1QZzBO+WbfTkwGeIfA6iiqGAxYpL9ICprM0K2KFc/bxgI
 GtPnfHAbr83ONKjOS1kgwzN/r4vnQEDzjqba/kWdv8BVdBKhy63bo9C1kxSjAudmDZNx
 huiWok8aypJrdI0TT5m+FhYdkSXdzItpbCd0Ih1Ov+UeduqtUJTs9Upf3dYK2GNdbRAW
 3RgL1WkSd7PW0JqWOeRa0LoHkbZ69Wbak7CAud+3om2K9FgrgXnY0UUydOBmqLXkE3w9
 mzm3TeyiudEYt5GpE/X9yU0bb5MTJQZ/L5aRZ6Irbx1AC9wZdj61ErUJ6rlglmj0Px80 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1ednum7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCabbc013821;
        Fri, 17 Feb 2023 14:12:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f9ujt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO13XTnFFfT+Q//NVBuceHQBS7N6o2NhSdmKx8UlWBFvVj3E4EWrgZX3wVkgghT32bVqitQNcPaNvWY14Dk+0pAJDmEB/D3I/fz86irOxJtanDtAQv5LS03FThBaCzn9V8ENP1eu4mlbBxKBSvle8GDr+woTz/z3Fgw/rUS9h4z/gusch/oQkGcQgu/H7nSot1jXuPaGoZeguYq4HTTnD+fCyLeGqbe5QBi6MnQ00gkYmz74PA6c0ae81WouZnQBZgIQs0/vUM5wdemkDfXEqtqcAizI9eOIflbIoVz0uCMgQCMkMK1GotzJxUUYK+WVEw7ZZrXLDweGnkjYGl6T/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhahvLgT/JAHXU5J7F1D7UmckdyQvrSSrMy0xssoq1g=;
 b=ObXQs/eDcsfEPXPeqalnKRD4FSE/AHzxWwrSTaf812Xq+uGuCngGgwjy/OZlNvstarS5qZNyzieIK2YCwV8Juh+EVYViGQOmLeLtsFz9FCyKzJoRErkIAJlrp6GFLDZ9OaZfgqRV2aTjuTxbTm4QL5w/1XSyDA8fglf1pYjIB9iZX0vJ0cNjeELQqQuR8lC1PuriWv96MnsXMGUIyttjN1GHlb1ywVvjrtgKWnclnyI8Ys8ZIzchYLv9DUXUszriuZutQ1Bk45ymkK9KBMK4SVtrWmupMs3bXlMZM5TaWaD4USIwfWpHPSQlL8BhZqwQfSpTTiezmq0xJTnWksLfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhahvLgT/JAHXU5J7F1D7UmckdyQvrSSrMy0xssoq1g=;
 b=pO3TXt2QGdzZVVcC6EDT68NHRhwzfe7aS+7+7XsIyV9cAnRX98X3Xu8PMlfUp1BvvihK4HqfertGQvKxyOND9YFTqSlWbTRO37JGxEu41McFbybw3r4Qtpt7E9aP/sr/VSLf//qQNXLgpp8WZqyx4WQmuQLScY2T8Osg92YoKF0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:12:53 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 22/24] kbuild, dmaengine: s3c24xx: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:57 +0000
Message-Id: <20230217141059.392471-23-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::34) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4d70b2-5f7c-424d-0aeb-08db10f10ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t3C6MaSv886vfcrmgap4KbPhssxuPsFbIC++VdhtPaPCt4OtXsoIJU7yANg/7b7FFEcxFrFVPPQUVxLUHKUek2AAuvBAf0uHonw71XLlGpzLdvk/DeqluJRHXxpjNcih2Hcc1vUC+zMbMxK+OfZr5laJqoY8PsDFCoqFUbT64iRxdJdgllXhBFx/XhiSJXjZEAU85zUimnAx2ARH+LNmXj1AcxX0hDOh/S2n+o/GRQw+oo28jnWK7sQMJgnNhqq33eSDMd8MLzPsD+51rRw5X2F39Z7hLBjXheb8Y05bmePgXotbet7M9N3x5dv11ltLUtPstvizMKs5LX0kS1kGOxmNGKEYFFV4fvEDWY7NlVyL9qtZhAMze1RPdl071zpc0aZVnmTyyZ2CVYNpfGnGoXHdcA5GAnFjSnwjOejY8r41z5swIad9/p6OBF4e6KafmNtHGyF2w0Mah6bYA+Ln5EQSPegVP+SBJNO/nPhOUgojswP9hLIWi7nQxK3EC9IietHPdj06SxnLH+L06WrNoKf3cVEbQIe0Mtt6y+GqASvYNKlr17tlyWcQ/22BW7jUkSdvwIXfqkhdbVp08l0G434eZ6cFaRby8uNBUyCoQPMdP7HoiTZhjfKW+kVqVs9GXYbLVs6Xg1MbrMCp6rjSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xRrCqxyYpbQSr0Eie/P0sWWBMIjL03XlsjoSycXrvaL2brEQRXKW0T3n0gY8?=
 =?us-ascii?Q?Ssh+qIU15LeM0vVy69fHwT0aXfttrSo79pJYiHhQzfaiTP7fyK8Nc9EEO4lZ?=
 =?us-ascii?Q?S5InvAfF2ahUVplIyYqtRRWiMQOySpBtYg49g02Jx7ZiGY6Fld0CvgAfAmBY?=
 =?us-ascii?Q?+rjK1tK0Z8zbsObRfOqDFT9vFxk/LW5nwaSUZvMWUL3jYk71EkVji5g5rgYl?=
 =?us-ascii?Q?9HV7pj5Puo8kIcCnvQmVUxY/0SV7C7PC+psMYpv+wsA5GtfUNfIFM2ebM0Pu?=
 =?us-ascii?Q?uMdXU/DAqOE2xnzsVOOJUOdqAvI+VzW2JWHP621AcK6V3V7Tg5mvAWV14U9M?=
 =?us-ascii?Q?TrJ//J6O2tDB7dZ6YtDqFpWKXJZwqjTh9POpYQEd+SUoboJ/Vx4A9SqWmyAw?=
 =?us-ascii?Q?hf/sU8hiyy+zsxVNY2fePho1m+f7k1HR7yrnlbVJjiDbxtZZMM0SH5Q/8hxj?=
 =?us-ascii?Q?1BwL/XicjOBc+/a80/EG3TcsIzGfjkXwHkT00NiBEHc7VmzTHrXiUySFpjpf?=
 =?us-ascii?Q?CPYUonJF4EN6m9rYOtGKdw0MrntHTb6e9vlq108K6ViFVo3JxJSrOfIwG63m?=
 =?us-ascii?Q?1wopnR2nIWUep5PGJi9f04foKNiB4cOh8hyJCIhtfeqLHOFv79C6sqqlZhRW?=
 =?us-ascii?Q?ti8yXOZtEEsOqFsoQKBuC3+YonuAjHFWEvAh3buJDypfNsQzXQM/NpSCBmgp?=
 =?us-ascii?Q?HHo1sBq2qkhii5xwN4F74sKis8LFY89UaPeBkc19paRlkgotVVR2As+WN6iQ?=
 =?us-ascii?Q?MgmbpZ452DeF34Jl0JIu9A7jRy6M2qretpwtDZBzvEjCPmIoKS09zy6rTmw6?=
 =?us-ascii?Q?HVgBfbW09EXLQs13XM98p1z/j4OW6cyTGUDM4Zm+fxoqLmbeSzKpkmMF6UVu?=
 =?us-ascii?Q?qT38SnqLHlNdvhybvOoxjG9TKKZKexKdltXONn/2mT5XIhM2jWOVPLnSOXzw?=
 =?us-ascii?Q?3JkPEBbRVVlLLk+0wIeXXqGf0dmMChUXf8ymY9ODUyNwkYtCwNtfSdtfRI5I?=
 =?us-ascii?Q?UUHzk4+t0NYIUKDmiXa8Vl4Hj+OMxApRFzYZOSemiGrEsLTQYjzOO1ZVk5tJ?=
 =?us-ascii?Q?iMrISTnmfOn8eDv199kNMHIjd7v6HzE1y8Qxc8V7Uu685A0sCZbzj4Um5PRX?=
 =?us-ascii?Q?2pDDrRGPfFOiBEd+GhHJDrpI3hsmN8Fdt0vl1Evt6v9gaweqYPaTqXK1pax7?=
 =?us-ascii?Q?ybSKLApAUMkXkj36nAytJz7b8FJK6hypht51aJlba5QvnsZAtJ3GF08C37I2?=
 =?us-ascii?Q?EZmPuuUCQdFn8hSIBwa0IFHr5/9ZMR3PfYdoKgTEjRIgcsEDnQ54xLyTVR5+?=
 =?us-ascii?Q?+P/ZtJDGDpTYowBe22n8HCe90SRdbmxhJ19GMWk4IKNPjOFGgEtYROCs1vgo?=
 =?us-ascii?Q?ywPOcfVVzWZuRStHPsB25xklRKgRJ7QTiL+KJyWyqwGPGI87GrFxMiDjeUj8?=
 =?us-ascii?Q?ioS0HPm+NRiOJDzHHJ8VIwN5V6CTZj/+GAegzmjNq1b1/Ig9UBreBEkwjN6a?=
 =?us-ascii?Q?b8jrF44NjojAVnWIeBegWBb5AB6k4JXHycM9a40jpWdzQZ71MRdDr+HQKhIa?=
 =?us-ascii?Q?ok+308Bd7NhROAWjXgAgefrBqDS2qNhMZY4fx3n+ZOkUTvqLpXfS3gWFElTp?=
 =?us-ascii?Q?YvQSbL6hCZPpzu31ICyr4V8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Belfo43bepC0+RFTnh6P7pKsKc+zJTuPFy/BnUafeIkesTqVZR2ypFamaWUprSbTsHhDOCJM6gNTz//VUB4WyXruZJcvkscXfh9ScPJrGRwvdO0wY7ES7TcGp1akbx+zZhCPPgY9BDj6vsyy6jth/zgGvPT/qapCUZk/5pXpXZ3EjTDPEH+WYsdiX0l7Z8Q28p5cKHFky9wUCWRLbe9aZbPy1rIrgsBLnRT0PnRft64a1B/d9ZmBVanVKhONpDSyorhZOltVUkWUqtxMLq9fPl0zzdunrGFzXUlzdTMB3TMqce+ElW6gReo73iyInXA/p765s6a7p1JQ0Lk/i3MIShvtXteFw+C1ui/1cy1O6LBT9Xry7bOmmHoQ0QzUM2r8yhJ3l034/uWMpaEPrzEYdkJWWVYqnxiuTf3vcn/Fr7zUbZdh2ik39GtJmZcJa0djn5EoszWspgM6xZSkG6uAUgDe6CXucjVT9c6VGsfecjMKgo/l9yhIF32fjvrmaRphc0IANpulh5k9Toy03DKZmFS/xlQGOyHhSEMai6lO3X0mricxat/88OvPJ7XW9xKxgMuRC4NcWVZ0KnSZ/Oa5YUHTPkyDp3tLDHOWttTZ8JzQlcDGHVB/+d82f7j456F38NAGOMNZSIxIUCMBYsZjpOzGwUYDJ5zpfPWEfYAMFcEfkPrnNaWAoS6A8mvtR67JtHZhHmb4pC1aJ2gxjn/dlsvIVwKkQbwmKDAiUZ0q1TntrSKDlwSI0wt123yQWeF1r1+tI4Yq3u5zVgEptd4ahm7XuTsSCwzY/6Ptl5SRt5ApNl9EneuNPQfQt5V6+TN/a161W89ktgJgr/Vk6eGtQZMtE1k8Ag8YQkuFM2Ng3fM5dBsKEbVJyEmJNHGMGGXH/c2rEoXK06qQpPzUy4uPiQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4d70b2-5f7c-424d-0aeb-08db10f10ef9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:52.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0lfBjaKWlkFS3acEHfaCvATKX8usUVB5NvhdZceET1KLJq2EqRbhUiqGLOvaPTiJMGqKPomuaablF7j/I8BIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-GUID: PBaZ2FbGFb8dxqs9OyAUAXbewTG_p4o-
X-Proofpoint-ORIG-GUID: PBaZ2FbGFb8dxqs9OyAUAXbewTG_p4o-
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/s3c24xx-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index a09eeb545f7d..48965baa2fa1 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1425,4 +1425,3 @@ EXPORT_SYMBOL(s3c24xx_dma_filter);
 
 MODULE_DESCRIPTION("S3C24XX DMA Driver");
 MODULE_AUTHOR("Heiko Stuebner");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

