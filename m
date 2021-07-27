Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD63D714C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhG0Id6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 04:33:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49484 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235946AbhG0Idw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Jul 2021 04:33:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16R8QgcE005719;
        Tue, 27 Jul 2021 08:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4Z/q6G0tMCJCEhWz8JpWvG3ZMpQxHwtrR39lcGNOY3k=;
 b=jqwAUIOEb17mMiVr45L9ecv0ubQSiiasYjPvHKr0Z4LxkdEsRXiXvVpzVLFptiEs0cgk
 Yh1DfAEXlH1kP/1aLYuaE8+98GGY2exEXWhIOiFjyovgPPKWaCziRdvrMdocv9kycZqp
 /c46OfcIMHehfImT/K2rlKbujA+1LZy7L3aWf8/hxziQidgrG/66tjXAe2HnAoI0+HwV
 lV3wzL6Y4lAmQCnqfSyTuHx6J0yKj0WZYmXIIf4PfMPdMlYx/a6hq50+24GVfbVo+YBk
 +B3tROBACiv6aKJGJWiMacng0Emh8jOTFSP+3WAFxlBUuUtLP/y6aaNcZTPLFHaJy3+l fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=4Z/q6G0tMCJCEhWz8JpWvG3ZMpQxHwtrR39lcGNOY3k=;
 b=IdG/ReFPzYnjhFmc9a0lqq4Kis0dTrsQCW9mahCz3gtl7SG+kD/bTwsyrJ15IbX0z1M6
 MChgG4/+tmWcjk5Xkpz4mG+WRSqiYCOXqpALSXmYa4TwL7wJJ4VzGzzYb0RG+1oCk0nT
 R0jlhEcCC+4zzGVObRFoKShmu1Pdi4te5k693cv/DaFAUwZqdOxQ9Kbd2oOXSyaFlSCg
 ovb5dyfv5OA0/W5jy7x2SNZOq3REYPAHczSls9YDQRHVlZNakl6c1JEpzLiq35FKfmcH
 JVexKnuGLqQnhtxvsBMS5W2Jdb9CLjz26bcPWCVvC33wnF6jcs1UHaWt1ziF1rMxIcI1 gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234n13b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 08:33:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16R8UqsA011516;
        Tue, 27 Jul 2021 08:33:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3a2352j7r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 08:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPucBvpzWEXrPnwJd/0RoznKoIpvAGS/6RLWyll6lwdrSYbjPcv+l8wrhfe6/qVGNOgbDQsJlEatODiEKHRq8cvvvS3S6OZx+C2ySPWifBl1pH/tuSZlhvcfsekPX4sF5ZL5QmjjkIf0xiz6qM1eRf7IXf0koFr0CQ9/NmPbtct1QJ1DM6LOrx9yIvDvxqkQDvM5AlSkVX8JjybsNimSOgJ2IP/fbnTCXiN4I9WIwk9S4B/IVXDhtGHjJPCpsEfIs9XgLweBfd5WRqqwv1CUxuvfm8NAlW3hBPmZVpppLVGYsNjt4GQ9p9Z670KPeFmZ+3mP8MNwGi6TbmgS80VPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z/q6G0tMCJCEhWz8JpWvG3ZMpQxHwtrR39lcGNOY3k=;
 b=j7c8vqZda+S9AGnZkLfGrJkLm3PAL4KOiu5cTv//hIruZPk7nLkgnUyslObJPosejNkruibK3FdTLIQEQvahaHb9AEkCW2ii7MVkhy8MKvGA17aTm7HEkhb2FsOhBtgZilYtxx6qoxo6UTMnUXspkQrkuQl1NBsOkX0oGYSMrMUNH9nF6R3Bf3lmlTVIfOxZ+Snle5Gb98CqXy7aUrO+rqDdsp95C35n8CtvLyhXEXHUWc9NjBVuEIuNGTSH/4B5dZPv/DNHfuvsDpkv0zSBuMotHjXXYFZDb9ePQtLqzkJYuopwxx997JTytS82/o880X4KvK+rlsOy69/aNFs+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z/q6G0tMCJCEhWz8JpWvG3ZMpQxHwtrR39lcGNOY3k=;
 b=mLUIZtiLNmFwrZ0kRXghNJutZ4ZK/6cS517OeTnqjt5SEfWvj7F6yhYU3ZAtNIIYlhmOslBxjsKnxv+dA1O2hW2b6H0UIJWbCh87fGLEXwavZv/aZRT9XYmoYY366lmXXAihsfVk6AsNDwpN4A9MwQVno/NL5kTtBvdDBJKN+VQ=
Authentication-Results: socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 08:33:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 08:33:46 +0000
Date:   Tue, 27 Jul 2021 11:33:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hayashi.kunihiko@socionext.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: uniphier-xdmac: Add UniPhier external DMA
 controller driver
Message-ID: <20210727083333.GB19121@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0133.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0133.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 08:33:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 662b5f19-430b-44cb-432d-08d950d9400b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4468BC5CD7EF039F6E5896928EE99@CO1PR10MB4468.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uX6Pie9Bygmc5hGojbokJyaTIsCWqYR5gVnNeYse4jv0ccPkWGQqE2/ud3F0ZUIwMEsFlrmyqqB5oozOVUB2TJwZkbKs1H9C4qBdcDIrStA0CLq2yiZ+djey5iCzOGtFmiXDIywb6grgisQSeWpig9mcBoQYM10UiAm3FPOEsz2PPiuXkbLn1kGgrziG5T+/qhNwbAToLFfjPx4GwcA700tENB5TLZ/UtWxz3VrkyKc7izXMk+pcxp5b27YmdyTmFl+xgY0exTK4NoXAnyCV+gEtAKBjTl9gyJvM4ZX1CBrTxYMenAbOyTYB46kmhHI2fJ+rX11wSVBSNur3x62FuMROQ3hH+nPhmMIgz/OVs6DFZ38A9VEMG9R1R2NdCM7nCrXFIWsGO4A5kenXGLAabUSjujTra7AKA+jErfinF2nBP/PiSuAKHiuXbinCITWawWQWwaySq9pYXNQKvfMQnyT8Qc1qTQ0v+Bwg5JsONOno6Cyecmo+1HVQWln3wr7n1fkVu9YWGesUnOOywL0VlVAQwCGqiKF5UimI1Lntsc3dPlHIiXdLrIvUbw8kV8dTJ/AI3AkwhdOqXxFyzOPjUs6JZ/lsc8bQQ2G96G/nqofjOKfUePJChOicDjzRc+YXB0xqJtERnhS3cG1BkWjY0yAe3/OKBZ5HPO6jbr2tF8IalwYLzkVCgjHoCXh3H2tC68NAapu0MtZVm7bWfun5Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(1076003)(55016002)(9686003)(52116002)(8936002)(33716001)(186003)(478600001)(6496006)(26005)(4744005)(2906002)(66946007)(316002)(8676002)(44832011)(86362001)(6666004)(6916009)(83380400001)(5660300002)(4326008)(38100700002)(9576002)(956004)(66556008)(38350700002)(66476007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxWq7vl1AAUn+409FOp6APHbP+rFv8WmKQKUZZ/PODqYKyg5JeGJDvMtAIUY?=
 =?us-ascii?Q?TJaUQA3z9f28qzV0Qiep9VPeh74s5jHZx3oScmhtqmYvadMMKkgY0iI4fPpX?=
 =?us-ascii?Q?czpYIsRIT/S4V5J1Do/1Wm/SGT2wEchopax5rhv6fPnxkRvY4rm3jCNBBUoB?=
 =?us-ascii?Q?7t5O/VAYoXcyJ+ahjX9wlBp3DuV4tPkUNqF1+6XExBtdF0szXXPYRzudsJSK?=
 =?us-ascii?Q?VCwxn6d9Cy1Dmn99r7qVW8N4V+Q2pTZEF1pYQWvFSOrZTMQ9KPiuQ0deNDah?=
 =?us-ascii?Q?gi90BO+hUMmqcZy92Rp5pktqlkoN+/w1nrAXQzWJjQr/+bUpz9LVZYTpS6/P?=
 =?us-ascii?Q?j4NbLQo53yInO+Xt6dH7pX4ycXVo7nnVIoXUx0ZFRDNlaRp+70dPT46bghex?=
 =?us-ascii?Q?27TAi+Lyi83b4rrq/OA8rIubH7xo1EZIzlBdEPLQUy2lhGzYeVJ1aP8CgiJz?=
 =?us-ascii?Q?NCWbIZ+0ptumUtvJrVpvvhEZ612JjI51e3zTlbCCWVjxwa2UYycpjD3UP4Sq?=
 =?us-ascii?Q?GqFS6hw7rDHsZcci/jIHjVeXM48vZMdOtZr1/1u3w8JYL0BKU5z05FY4qSN3?=
 =?us-ascii?Q?GcfAzy/wxe87Ui8ORdLUGHxjUBBFpoXyghR9O1z7YklPu9dRWTuKdd7ijAKf?=
 =?us-ascii?Q?AdsHkdyYman7dcbON8eHwK4ZsnHNqvyIwyrj7GqHxQI0RurwCk6ZBbyshCB4?=
 =?us-ascii?Q?05J82fF7la0wgAemSasEOvV02lv23tTxKJmAEnmo0GhwzPXbShpM5U6ZJhwj?=
 =?us-ascii?Q?up4+aMLM5U1TG7goVNW9NArcyCToDUe7Bwnw34MjIktSTQvoR6VAd8/gmujI?=
 =?us-ascii?Q?yQ4pRm4LYvcW3lgO9pW8Xau8t4FxEUpgl3vZu385IwmzxKnmLEusdQMeF1vy?=
 =?us-ascii?Q?yGj5rmtAiL0rKBfTevw/J2DLQzul3kDMOaI0A5N2AXY5wGVuLRYHvt17prru?=
 =?us-ascii?Q?zwpPpJ/peu+y+l4Qhxg4nZTGoZpgzPlm/+n2lqSHiqOeKcKFfRBMiFsZ1sJZ?=
 =?us-ascii?Q?dOtLihyP0NCC66EdoN0x50GKUsGbL+4wFYR6Rw0RKv0Udby+NrJH3MAhO8xZ?=
 =?us-ascii?Q?Xx5i25l/MaBb7EuuwbzP3KzZX/2lAg5GO2l9GD0JmBqbv7wpFH1KOlsd1eeb?=
 =?us-ascii?Q?unl6j38Z5w3a4Gcf2qwfNMHQ0CsGZ6XrMUfEcnSnmwUWUd+bBeTcvzgzw5jE?=
 =?us-ascii?Q?i3ve4inOUFxxeZBADDwvK3agbdiv0apfGkVMHJG4wjqOwKMzfm8HcEFLJrrk?=
 =?us-ascii?Q?MSozBHa9fX+DST1Hk3o0EI88RxVTm+LEJf1obqM/3YIMcKe58V+6/upv9WVJ?=
 =?us-ascii?Q?9qLsBKfG9bd+mDaptvs4WfI3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662b5f19-430b-44cb-432d-08d950d9400b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 08:33:46.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr8lKvtQxNopfIHt9DNmkVzT9RIS9Nb+97ci9iwimbCTJrFjnGrMEbFVY+FtqyUf4ojBWMAEWCtezpd7LznAT0JOmWEu/+7bJvis6IWJh68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=705
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270048
X-Proofpoint-ORIG-GUID: ozvScGr5J0vVRQ98lgjtnvbMPSiecxsu
X-Proofpoint-GUID: ozvScGr5J0vVRQ98lgjtnvbMPSiecxsu
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Kunihiko Hayashi,

The patch 667b9251440b: "dmaengine: uniphier-xdmac: Add UniPhier
external DMA controller driver" from Feb 21, 2020, leads to the
following static checker warning:

	drivers/dma/uniphier-xdmac.c:212 uniphier_xdmac_chan_stop()
	warn: sleeping in atomic context

drivers/dma/uniphier-xdmac.c
    197 static int uniphier_xdmac_chan_stop(struct uniphier_xdmac_chan *xc)
    198 {
    199 	u32 val;
    200 
    201 	/* disable interrupt */
    202 	val = readl(xc->reg_ch_base + XDMAC_IEN);
    203 	val &= ~(XDMAC_IEN_ENDIEN | XDMAC_IEN_ERRIEN);
    204 	writel(val, xc->reg_ch_base + XDMAC_IEN);
    205 
    206 	/* stop XDMAC */
    207 	val = readl(xc->reg_ch_base + XDMAC_TSS);
    208 	val &= ~XDMAC_TSS_REQ;
    209 	writel(0, xc->reg_ch_base + XDMAC_TSS);
    210 
    211 	/* wait until transfer is stopped */
--> 212 	return readl_poll_timeout(xc->reg_ch_base + XDMAC_STAT, val,
    213 				  !(val & XDMAC_STAT_TENF), 100, 1000);
                                                                    ^^^
This 100 means it can sleep.  The function is always called with a
spin_lock held.

    214 }

regards,
dan carpenter
