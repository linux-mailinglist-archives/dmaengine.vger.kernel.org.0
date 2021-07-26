Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16BC3D5450
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jul 2021 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhGZGy1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jul 2021 02:54:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232031AbhGZGy0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jul 2021 02:54:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q7VjOR022649;
        Mon, 26 Jul 2021 07:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kxZJx4+4P7MKI/Y7n4H11aumBDPdxUu2jnSlMz53GM0=;
 b=mQ5xQH0HOOIzmQJAbY9hXS74MbYQMUi93a0kN8tDKhRhIcHzuzaagSPjApUx2FCvgPeB
 2lOYpdlykjt6t5qLgpfj6RDk3q7oa/phe9F7MsSTWVEuGzUB+p+h3Vw3VWBcOx2hLY3a
 BQXGj/5tXu2qFDJBHdZxUR04+sXLumDYCF/rW4sxCpnd1H0Aex6i7je+NDys/ehTQa2F
 gg+lccLVoE8mpwEsbyT4xAv7uOQtKWDXpTicsynCszZWpyDrxqbFqyI9Suk51ooOJ22R
 mexPxt0zOnHFT0FCpk04o0KGwxXmU//5zfhephQlMx/MdHhunqk83K8ryFj3N1P2/Hxz Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=kxZJx4+4P7MKI/Y7n4H11aumBDPdxUu2jnSlMz53GM0=;
 b=fPwAvdZZvlaNkUikzvGhqAAbKBHsDk3MjrCUgSxP3qYd9cIXMy9ES7su3Yz+5dPIJ5U+
 I9sLuufuNd83wkEpZLMqeYXWuYun7tk+tgyuvBJnZ9MOtZRkA9PShBZrEYsf/POm45z2
 gjtnJcsgU40ii4nsd0vbMxHUDuv/4i6c4FsazCxTRk/tWJJz74e2eILFTanJsp+NMN0/
 25orbBmzsNvRatk578yJwAPQ/ilkPwO8xEXtT+/WK9YnU3svCSRSfS1B74KPjZC1Dvlo
 yqnzVGPEA6bFA8kFmcdmAGnlJ5/dZaY4ghuNqDXfwXzl+qM8W/GpxThgv6itwXc1Jvt4 cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqr55n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 07:34:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16Q7UoWM138344;
        Mon, 26 Jul 2021 07:34:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3a07yuv1pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 07:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCh4c0jEtJnAXdBTfylBV7uRiHZn0nkgJeZ6IpEX5wZqvJglS4GokGUz11NGvHbrpGhDNfy8NiGTyrRqdPZnOCcj0OEyI9l74gjuqoy5bexQ+gee7TFjSKkZJ+ZkQPMHxib6wdnGUoEQrGuVA0nYN94HfTeqahhu0MO413b5/ozr2kBcJOKxXmQWcik3MoRtWjAgrz9st8yH3bddbTrVfFA6bnYoY6DY/0w09j41xDKXULJurXWWL/OTqtHm1KJnIlW0Qu/fFk6riHnVZmHfZ8IJ9aV0oSNEpLu8KyFbakIaj5tSsPM2oLoad8YGtKoKx4hT3YYRB2AOo+fWUmn+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxZJx4+4P7MKI/Y7n4H11aumBDPdxUu2jnSlMz53GM0=;
 b=g7BSZWVezdEsnOU/Uo+AIJOWZ3MYuNiDmd9eWX/1cfmnAsYhYlRxSjwZqL324JkSXPKzhsZFMy1bcqxJsoa5zNPjdsDgTF04/wTrId7N8f5f51G8nTZDq8Z4Cz7hpJr7rNTZ+1xhNocnVYpE+oULR8mjQaLVKa0kRqQMKym9vhVxzUHPeOS93egkbCisIOe8+I4wlLbnfUhDsjNd9mEHtVV7HryN0eVZF9GPDgo6JVRB5vVo0lEgrr08agkbUyOBKsfJI39m3p/3+AQUS57lzK3GvqyU7ftqL9cJ54RM5qxK5s5yfwtvJ2pboXMadLB4ApKzILdXpUFcslmaJDdReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxZJx4+4P7MKI/Y7n4H11aumBDPdxUu2jnSlMz53GM0=;
 b=owzOZDyoVPjQPo+JxtIEZbtskjUnA/deqEar2y9vGt2iO9UuToVV7Wdg61pWY3exGYoI6pX6Z79zVronnNqBr4GRcb7Yr9H34s5OG7xfNN+AHGaTelXXeuHg+NQx2zRwHBl6+BkONU2HtPyaI5i0e0LUmN+xjPdL3jKfdmh2y/s=
Authentication-Results: socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4689.namprd10.prod.outlook.com
 (2603:10b6:303:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Mon, 26 Jul
 2021 07:34:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:34:47 +0000
Date:   Mon, 26 Jul 2021 10:34:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hayashi.kunihiko@socionext.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: uniphier-xdmac: Add UniPhier external DMA
 controller driver
Message-ID: <20210726073436.GA9691@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28 via Frontend Transport; Mon, 26 Jul 2021 07:34:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08406d5-42bf-4e7d-6282-08d95007d830
X-MS-TrafficTypeDiagnostic: CO1PR10MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4689151DEB902C6E94BB532A8EE89@CO1PR10MB4689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaALvz++GS/TQzzodgBA+r8XEcnh3CwsVF8kdk2jE3zA0Vr+woweUysn10N5Nykp620HyhODJ5eTo1L/E5A5OmK0VZMWqI0PsloSvBnlGxBXBk0r7j0xkpgxwHhgD/JB0oMJQmprOd+Fpa2jla7jv9rgTJ3UKf+nR1aazeqKoJ1s3tMnI4m/vsaxWmVGz5vjgnR1UHAwn1M4Bzky5YWqat2S7mEaEcSkYmkyELudg/3IWendIPuuN5PTceTro1Ir1Hrc+xHK0JEbJ8FcjSp69/HpDVm5sTD12FFCtKeiC14PfaiBgG5VqxpxnRJ1X/y0ca3wod+s/rGr21OYMDe/BW/3knPITqpgW7FEaq382aK5JXRm2w3ZnSFM9Acdc78dTqyJ0tJsYJ6g0SrPFX66jngWnUd+VVlzBKkX21psya1cJEWe+dULqjOpBObrcg/wzP7H3krvHLDFEOp0zFYYuBa7KNXSy7YXqEtDZQmcQgINFaS4qC6rHw2uggHEc3SBtoaLnch5b8tnW+fuWXF3+MMWsR05XKJkKv/2PiNwPlG5VtJSFpc8eJaaf5TRcaNg42Z1C+ulnIggGAAXI56BjLOy0HOZezLzmVhMyvac/Kkkgge1PV0wMXZXkP7bsieWjdAAOD7nrfHDSYOVPJZxoqkaYANrAOTPcgfKk3yvc+MwEmTnXvdWsDq7GhCDOLKt1F8IfxK053+24VRubrOKEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(52116002)(1076003)(186003)(9576002)(26005)(86362001)(5660300002)(316002)(2906002)(8936002)(956004)(6916009)(4326008)(4744005)(6666004)(6496006)(9686003)(33716001)(38100700002)(55016002)(8676002)(33656002)(83380400001)(38350700002)(66946007)(44832011)(478600001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b20z1nu9MbAXHt17ylmkowfEIf67S2JGuOK7Uyd0tzHy5iQThum61YApVT4f?=
 =?us-ascii?Q?L7ZfxgclpwEdp7m32ijOwdezeQj2QH+xHQB7parVyI8eaxbjBlDoBb0Rxv4K?=
 =?us-ascii?Q?HrO3d0sdKOyNkpOpM37PWf1wBRY9W+GX/si2MuPxt16wlnQ0lUdtBw//wsDN?=
 =?us-ascii?Q?14ljAoqRnlAgJ298Lzd2vAQFW2H38dmGw2KZgbXt7y85ZXlDVFslLsyUqFWg?=
 =?us-ascii?Q?CzU0MjJZqOaJuHkensicm4te6BlTxOydPrZJWO7Qm/nkuaOLkoQmfdTgdAVj?=
 =?us-ascii?Q?2kTqwBxiZLmUmJ/STnJudfNgHGgLCHuPGzWbuejIyUVeDfOM7wTQ8Gho8gnm?=
 =?us-ascii?Q?JD6kOxf0d8RmlVZU37oJu+HPPOd7ira2ZfgdBVJhJNJtjHc3x9omDeyMqtIP?=
 =?us-ascii?Q?sKHqssNxqjckV7Gr9aNLLW/v/LENrivtwTnroescqtAx6UXN9DEJOA7vxw3o?=
 =?us-ascii?Q?JrqJaAWPlIog0hRmoYSCg7ok2AlQby/+MoW3BmPzaoqSfJk3iVIdlBmiJFgW?=
 =?us-ascii?Q?h+cSdKaAvGTRtoMpV7opErcPZ4Vwj5WcmifFLDsWLp1q7pVFdGUp7JtRHPXi?=
 =?us-ascii?Q?6znNfQO+0+e4WAH29eiwlYiBasZ4TRnMnIll2TZASX2Oy2CW2IGSViQ0q2TG?=
 =?us-ascii?Q?7GEUEHW0oqiMcd/AOgnP39CEjStWNO/FAyH9zGxQILFfxQXuWYKYTHnMFfOg?=
 =?us-ascii?Q?rtaQLyqtbSE9HLhufaYSUL7D76KVilkY5ckaUKWjQ0YZ19/ftROjqmKkRVVd?=
 =?us-ascii?Q?UM6dG6LgF9we1SojX7be+hYeknCO+wwf2tcbCnJE9AbW/7A6s+FwKYcG+i+o?=
 =?us-ascii?Q?0163tP0HOoLK/RrzYd3RI1e/gRnmDZgYCnSrK2qeN4RmnLj0mu1dmehCcsfu?=
 =?us-ascii?Q?vRzFLBK7u56TuB+1Cd1oewuWkd4jJBeomz7ofVLmmS2Jq+AeqonftH+kneKe?=
 =?us-ascii?Q?MnQEh3q/pYrb0fC8bEjM9N8dvOJG/EPeoJBo48Va66ufsmOUer342qQIPk1W?=
 =?us-ascii?Q?the8jv/fjEkkPvyPK9j+54cNfrkwi4PF4abIzYEyK1QRMVQZ3FdU3OSVUSH7?=
 =?us-ascii?Q?pjDyJ8SV7XrbvbezbBROxfeFkpP1ixfXMePGpoTyb5+ZfpIYCnGbw27OPKJU?=
 =?us-ascii?Q?N0nupgIN30ZnDcN95ZcMg1C+AFKqTkiuXMolWJLsOcv7ghb2GFr2PapIfeUR?=
 =?us-ascii?Q?WBORvAsS+7T1bNec8vAAVJsFfoX8He2G6qvI1MB60VZN0BKQuMRwxoTAB4Kq?=
 =?us-ascii?Q?uDcu7LNNcda9ZOdOsf4CQTcdME5963Q5Mkjm2G/+CYqiJB5659wsu5CyJFfS?=
 =?us-ascii?Q?5tnLV9F+JMVFlhw9Ycy+OTWi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08406d5-42bf-4e7d-6282-08d95007d830
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 07:34:47.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aupuqVPdq6TUQyhKww+Q5N8zLdBSWP2CJX52AqCv+JPcqfQ7FA2DtSCVCbm8wImL8ZNfCXCVXyJdIxYm/TCNEctgbN4ZPUdm7XB5ktZeRD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=631 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260044
X-Proofpoint-GUID: wf2kom1Fgs39hxUGGapoP5NAnG3Ovlgt
X-Proofpoint-ORIG-GUID: wf2kom1Fgs39hxUGGapoP5NAnG3Ovlgt
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
This is doing a 100 us sleep but both callers hold a spin lock.

    214 }

regards,
dan carpenter
