Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58154DB35B
	for <lists+dmaengine@lfdr.de>; Wed, 16 Mar 2022 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiCPOhF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Mar 2022 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCPOhF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Mar 2022 10:37:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99452E29;
        Wed, 16 Mar 2022 07:35:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCo7sF011400;
        Wed, 16 Mar 2022 14:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IMMlCsNtSx3p57Rsj9lnyP8mBV4eyqm/TBHuqsizASA=;
 b=Di64CiFcLnQba2giD5Da3TIl1u0y5BE/c1LU4tzDvsD6Ozdz4UpEtdompHdA2jMnuPS1
 IbM+fCwBK6RPF9/uvWlQ3NQIPiPXTEvXkbLATpnyEiyBKNuZnQRhAbxJAbEHkKXOVeaV
 WEQRQ+BwgC5XHrwx9JCwEW7DlF+fl66awYlrglIoDYynGRI38b+RqmcSoeJzd7Wp0IXL
 nJYAgQApUe2PiKpyzViRw6KUpxzpev9HiHOV3xAV5fMKWHUNmpqrPIlzxfuqd1cNOrrV
 p/cDRs+RXjUSwW3ZyUqLn9njWPHK+QMcuCf/qW83V4JhzmcPVhhm+PhVVnhGhj3Hy8oZ gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pxdjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:35:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GEHkop016120;
        Wed, 16 Mar 2022 14:35:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3et658qdj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7rZBC/imMR4mk7ZsJNiWboUDKUCw19Uc02bReY7AHcCYel1ZAJttZKIXb0rliKeDdiBLXI/Pt5ZtmVOw07t3RVvl+ACybasagCakam6bmIGp694G5wKDXm0ARatXgEzEMso2MS5zd/ztJowTjj6mEu09hE6xyCzgbnfuXQE+rb1z1FZUP7Aw8ClJwn1csLM/V+B6mOklbUOWqFDqiwPX+8CDFdllYJY1YCtLlzFIAEDJkc4hvBH30MfK2MRedX2ZP5VIN5bW9JbNhAgCjXr5+k83AvzhRZhZdtTz8YQMT6RUsUC3Cg5NwAs53arWNJvY0+f8J2LzZQtP8OumT5cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMMlCsNtSx3p57Rsj9lnyP8mBV4eyqm/TBHuqsizASA=;
 b=HBKOR8kevUei6P/+FcczGu6sFLfjtCbgCRL1yKCVq784fw36k0R4U+qlHO1n0cBEok3Fy29U5szpg9ZW93Fc48bm3Y9T+I5JdcAJ2qap8CZ/ChI989xLULEw3qYcASP2dICy9hU9NEf2RFVaF7x10Qt2uj/ExmqqRHJ7KiG+Uat8CQgIz8eZC5ysGePhOfW+ZW9SiGYTuC6T4fec5wMe6qAhPW/iHuecrXHC4ZsBDkXRGGaWmqubWAAgksmVz5LREO9vwgGrA0swTaaK7qPS9kAMOmUeoTldGZ+77efi9ouEJxuFjEdyyLOuqKuMXmAdrusJDip3QJ2YEo9YEEmqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMMlCsNtSx3p57Rsj9lnyP8mBV4eyqm/TBHuqsizASA=;
 b=qBP9xM5pfz2jkQAjCsOLt6ylFr6CRLfhv2CRpt0VRljVQk4A/lTefeNm1E67bLd7fAK5wzdWFTh2nLIvytNXVxMSxUDMKYtmQn5GlG/w6rekjDCf8rjMHv4BuFcNX0QEGbuu0LyrAl2Xc32OiRWcv28hWDOGB99ENfpERPpmVmw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5057.namprd10.prod.outlook.com
 (2603:10b6:208:30e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 14:35:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:35:27 +0000
Date:   Wed, 16 Mar 2022 17:35:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
 src/dst based on the transfer direction
Message-ID: <20220316143508.GG1841@kadam>
References: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59220760F588124231136C8686119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59220760F588124231136C8686119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a4508f-4a61-45fb-d06a-08da075a3651
X-MS-TrafficTypeDiagnostic: BLAPR10MB5057:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50575426A76C6CBB8E955DA28E119@BLAPR10MB5057.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jM5rRyy9P/zts9Jszw502tCNZPHjEefsBHIKaf2kBiZuRbHJuWpjjbFxs8WBhMWu6pfJNCNw374oTPKlLQswXCOssX1bEG1WsrQjDsDb7AkQEiw+TZovGHIYZ/FghSbY3leAwD+VUASVBFcfNu0bRFfIW2I7D/6DK5l5tzhC0jXp8+tby8dFM20aYG6phQLd5ddSquL6RhKb7BXAAd3/K94tvkdpGaGCuAaw6LUNwJ3CdcmUMpvGvmIxJtiVc5i1lje+aYXr1E/doLzqxbGPQ42xJ6rarKZ+CQUOf7Cm8XdYy64jb3aUJ5LsM36mEjf/8nmShSkLBpzihFt9hRdpmDb7nv1l+NgFVTZZ8MquRw+0QEDrNpPum9jfBcxicHtMhtghGVrwaiwTlL5Rpzvsp/K8dRoTIqzwtpHZYLhV8PQ7l261whBREKFZPO2f+GsVrUzbUjZT3FuTdxs3kY2lRAn5yotWCGxiHMOR71UyR8j/cwNXvLOPsYT4Cm+kgT6jto0qujdK7saieWVI2glhpWjVnqGfSv2b/w98Xh3cbN5LWWQnKfCsbnoZLTuogJlUSOUswiKqu+fn6998WPgFOi7THL8J10FnT0ZzVTZ7kqVLoG9P9dqEYD2S5wC7usUFnpM8PtLzywMnI5nwy04ckwBplO7ldXHPAllFBimWo9XAkul39ofgWr+PZJvRgYUQ8PQ2waPJafn1ge0R5lh8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6486002)(44832011)(26005)(186003)(5660300002)(8936002)(1076003)(6666004)(508600001)(558084003)(52116002)(4326008)(86362001)(33656002)(6506007)(54906003)(9686003)(316002)(6512007)(66476007)(66556008)(66946007)(33716001)(8676002)(38350700002)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8TlKOV+F90PbPQfSs8fz58W4X5By9zQFj+iXbD8uh5ShBM5vw8nfKqOumyV?=
 =?us-ascii?Q?/rIUYXoN2txzvV1CsMA44czpK6NGVsPpYnmPeXQGq0JJ0kiJZdnnOKG4UjxG?=
 =?us-ascii?Q?OPSHcPeXPQq/MXiP+ramCqm8JOIqO966rT2Ojnlz7DSpGvR+wKkoEpv+R2OF?=
 =?us-ascii?Q?2AMRn0Dyz04Tit0NZoR+6b/QRAqpVjHBByptjPSlg3lEwcFoWSHvHeNnUFPp?=
 =?us-ascii?Q?WGPJ/g8NCHFFgL8JJ+PHktSW0SQkntZtJaYDjrqz7c2bvx3HPmbP1a0q6fEQ?=
 =?us-ascii?Q?2n9WL0IfWmKzs20EE68h0Brq4SRIK15CMGNrkI5nZCvWjMbkwb+yJp1zYyUW?=
 =?us-ascii?Q?21+lqD7lgZpoiTTlF63OYWFUGCFuwHxjP6AIetWfxYsumyJnnB075fKhdKPU?=
 =?us-ascii?Q?PH2rsZkaQg3dh6fZO/adK3J2iQp1iOENo/2/wBp+uThhplJNM/zRP5osopLW?=
 =?us-ascii?Q?Xw+qR8B2m8CJ9kDuNaEhnLTe92WspS82WgMD4hoDVkQYHSHBN3edb524Gbaw?=
 =?us-ascii?Q?J7ez4UVk5stcW9h/OVVJIMxE1oplZ1w80sJ3AzqbSa+Jb5H3O22qpjoVmor5?=
 =?us-ascii?Q?izgeHMKzSRm321bvmSPM4/Agvh6aYmjjsVKOL1nar2WXeEjV+ybo9R+Yzr6W?=
 =?us-ascii?Q?BHSBfpPOhDYf/RGNgsU2Mgre8tU+/lkql+PXKYMSCAoa3/bOAVAA58iUkaTB?=
 =?us-ascii?Q?UFn0qwHK1qlKG98uJcljK22lIw8loqbgWarbUX9l17UKfresFtQhWuukBI1U?=
 =?us-ascii?Q?KpuT7i860WbK9zc0v9hHtQW6R0g0zp14Y3xqON83r+A8LPEZzDORyboi2vr1?=
 =?us-ascii?Q?kmKgN/ZYfdm+GvatbmOaGyE3w0BqJJ2JZjBU6dtaUpmR+BLnOVeTJzhmjsqb?=
 =?us-ascii?Q?ujhTRYPaNkT2/VLF4f1fBB2xC4CAY8ulawZ/Ly6DynAwgR7ucp43vsovYr/4?=
 =?us-ascii?Q?U5PEa8R0DhmrkuQvoYEg0LNVktLeH+M/5csiAgChhIl8AQP/nfGyc2gLnsGf?=
 =?us-ascii?Q?MvRPf/Cq+TGcmayQpSLHqnLYDOwKnrnShiRiav1/zQzRIhDNdwOc2QgpD2Nh?=
 =?us-ascii?Q?IsrW7MmArRCpco781iR432GEdI7g3bYDuDEgmzS19/KanPpR3/5adghZw7Sr?=
 =?us-ascii?Q?ZPtFueQ7aujQmfRg8gbpTSQPl6rWELQWiBqUZMki5X55Osr8ZGnUAhvJIDrx?=
 =?us-ascii?Q?HrKbn3hijrXgmNR5z/lLdSZvWf/vlmLFSUrFpyc9FegOVn+oAEOtpaDtbXfx?=
 =?us-ascii?Q?MZZ2AIn/22ucLhW8ZSPLjwSEYg+pJK64xPlOCaef0IIw1vj7xONgU8Wn+x2/?=
 =?us-ascii?Q?W4Z+XZF87mQgGk5fRCN2sY+cOJcVSq/gTFmNR6CmqK/HupmOQX0D8LFEKoRY?=
 =?us-ascii?Q?v4hRVH2v3JodODIElLdz337ELvzu2PP8MjBH/q2KuH6N7+cJ1QM8m1ejHtf8?=
 =?us-ascii?Q?kocZlyvbItd2SH39nNU4L7NNkuL1RJLqwiN+bI5mXoHZHlW5g+iZ7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a4508f-4a61-45fb-d06a-08da075a3651
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:35:27.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdug1B4COc8YpfJjZ3T+bQWHKHSHCHdyiwW7mMTvqlooesOnJVaDIRh469PasHXb11HWxZCjfaV9+YOJuJ/P9j2JtRpEPdppitp07sEWM7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5057
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=700
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160090
X-Proofpoint-GUID: MtY1dpJwwApnbENoWgiFZ_Tw-mK7dwgS
X-Proofpoint-ORIG-GUID: MtY1dpJwwApnbENoWgiFZ_Tw-mK7dwgS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 16, 2022 at 02:27:01PM +0000, Biju Das wrote:
> Hi Vinod,
> 
> Gentle ping. Are you happy with this patch?

It's only been a week.  Please wait at least two weeks before asking
about a patch.

regards,
dan carpenter

