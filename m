Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3A44AEB4
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhKINaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 08:30:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16410 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235265AbhKINaH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Nov 2021 08:30:07 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9DCrvM009031;
        Tue, 9 Nov 2021 13:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ztoaf2EhhVf9LwsqNQ64izG78Ud2Jqpb9TZ56RQfVSU=;
 b=TEfwMqvdKfvt8mHMJaKNE4W9f47fpgq1tP4EcDKw7Tth+wZvhVOx0KYUs0WE5jAJ3C7a
 RtIFNt8HSUsiCEZbCfxqBswrw0hveby7sFCu5myctoaOze97x3FUFIGXgwJac+71s5rj
 JlKtQgiwHEOQSeXLZQAfWM6CAKbuA0tVQO/vew1PWBCiUZdyKqhEAbC48FPaPvNILVwN
 S58FusctJBwjfJbXMDNRbcEApeUomGKxa0rDtLMjR6+WGoG/K2/QexQ4UUYGGJ75y53M
 xuFFjQHDHuOchfZgM5WqYXJiWTEWA2yCLiT56Rth+T/EzWnGYpztQr1tEGbG8ozVObSa TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6vkr38qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 13:27:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9DBPaB112933;
        Tue, 9 Nov 2021 13:27:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3c5etvmanp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 13:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grx1KuK0E75DVcGmKiLbjyPusezF0Si5EqOxaov3bFh7vptnNaOXv3hkuRe7Xb02YGZBzjH7A5FFjthgojXp/yW1/SiGyTzqc3jU4+RK24Jy4TXq4YlyesXcZz+2weyKNMCrRg9We2lpJYqvjb+I5Yq81mdcpWcTbYPERWkADSlNT4PO6Nosa40vEy/yKccv1uoua13kefsZMPX6qyrITpe1BxGZbXzg4Bl/WhrAubAh56Az0k/k/d54a/pFNVxkgmSezBHB+B0ZpAAdgM+F2PXCKudlP3eWlgEnKisg/+J2G5uBSXjv8RT56lJQTfcnFUPOBkAIYeixQNrEUra8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztoaf2EhhVf9LwsqNQ64izG78Ud2Jqpb9TZ56RQfVSU=;
 b=LdrVLqbkPpUNPx45bsP6VoeBOzDz8uruyrtwwGhUxl7rrs6GHkMj1Ar6Gx3QbkZMbmzqRSB1vfflDnuzXvgQdmm7MFEu1xT8R3ExD7ny1p+m/HnLT/8QEfEKFUxZowHllnnkpRg7mIyApQJzjTe/zGQBqSa/OEZvwpVj9jiZVOtWv6OFwcsPc57rDQR0RXgWaPEBw8rx4qXjUgsYzPgXUL2dQP9iJsh0/hogKcsTYizGTmC+ZsJNx+5BDjbaxZjFFMHPwh/nD5NibtOvK813H9/WM/lqQm/nk0esSacmAlKsxTu+xbAUs9O00gKYb6KQzX7mH0dr6He9Sv+i3h7i8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztoaf2EhhVf9LwsqNQ64izG78Ud2Jqpb9TZ56RQfVSU=;
 b=RJauaW+NCsnTgkCrwtXldKhfgTYopAoMGOqXym8BN3vur2HS19mZo5PRUjuNpsnpQTEJMoY4m2JUbUyNZeAJJudW1vgxaiSASGbJe84xrFXlXvrVcBiPCplYCMOvLljDJjHHtH2SfAyaJcvjWs5sY/xIEWzRyNspgsLJccqyPvk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4402.namprd10.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 13:27:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 13:27:12 +0000
Date:   Tue, 9 Nov 2021 16:26:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Qing Wang <wangqing@vivo.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH V2] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
Message-ID: <20211109132651.GK2026@kadam>
References: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
 <e30467d0-55e0-156c-4eba-2838c22fe030@wanadoo.fr>
 <20211109132137.GK2001@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109132137.GK2001@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 13:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d1664f3-05c5-4420-99b2-08d9a384a2f6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4402:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4402236DD6D063803ACCBA3C8E929@CO1PR10MB4402.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BedH/j6VBNwyfCbsfuU2wccUzFqv429arxthFM97WfK+vwHSLDX1IcZsReo5Hpk28UObU9SGSDLR0tXBlKb5e0r5YnpJ1R5aPftSfv4ccpY4eh6gB+ydd16PAhHFratxlxDDoNTzpk0+Cuaprqvp25W8Nf+IGy1aHYTC+ptenouzShDJhu/q7hz9MBkWVS/JcGAvOJX/e9foJfy6K7f3YNLDu8fXGhkpoCYQzjSW8lfDBeQauMpr9rUtJNsgXIuus+YUzOvauF7O24sLF0N/vLecrk3f79z8faw7KwM+jXZ4z3P526cmf8R03u8zjucNllmPATW8HvVNxbEghSH7p4MzQwR3Qk+JZAKHBXnv8m5sf3H9nUfTj/lxCaQLHE0DREctnIOXVfXwsdkteowrEx+2SvXs+LzgPaaY9RQPtjl+8cNxJnkudw36QFWNfF8nhG90akC7TDFqPSD/32plPK6CWnZ7FG8bt/OdohLLYRBgzpfZEWfsQ57yEK/VSGOSm+3reBtpqmj6fhV0lPJeUivblSFEi8vprM+xqwQf0VwHZhM1ywVaLZn1sQuvT6LwgRYL1SYvClXi9WqkF/yAGlUsyuQnWQpr1EJWDfEtQFjybEF2pC0i2F8dxz0KCsx8Kc9n79nUCd34Zyd+3zmOUoCuAY7dljhghfAfrZBAUSw9gPfh6pmzeerLwuXvb3Ttyvz0ixdoQRlU7RaGxnvbGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4744005)(86362001)(6916009)(54906003)(6496006)(8676002)(66556008)(186003)(8936002)(66476007)(508600001)(66946007)(2906002)(9576002)(5660300002)(52116002)(4326008)(1076003)(316002)(55016002)(956004)(33716001)(33656002)(38350700002)(9686003)(44832011)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/CzT1+o5ZQJo67T3YnQodUHItGbWUXxySJIYgyD/Bh0l5v9QG5Iif4pvp+b?=
 =?us-ascii?Q?mC1LEARYpzkgQ7RZ2e42uSWInrRXcVD1jBBQX73dLROaQC5tb625c4hRzCKl?=
 =?us-ascii?Q?SChYJMOEkVvaDDdhd+/tUoW6lV8mqqnO1MlG5wdQr5Kgd7iaHBf+CrE2kJQs?=
 =?us-ascii?Q?Tmg0yDzbl0+oqo085x5RQyzoaU2NT0mo67EKsMw1uBfOfa9b6m+28V1XMnNx?=
 =?us-ascii?Q?N075Du1c1S3rO9WCIuu62VOM2/Qt298IeoJzumSyhxKThawChiEQGSxiC1IM?=
 =?us-ascii?Q?eUK9GZzeBvdSAix1qWtFhmG5oxXTFc2mugQ/UMC6mfDXIADSmjNmSN/nKVCO?=
 =?us-ascii?Q?YNmx4I43UnqVMfApfBrpmtMNhUdvO7gqI+R1+qn8epADgdWc2PBi2lwrT/io?=
 =?us-ascii?Q?1598UclImWSy1F1/zUOfEXU74bHaU1WFSDx3YOrgXKMeO+JVLgHC/qvmW7YH?=
 =?us-ascii?Q?67ZnRY/Vne7msR2wS6ccPuXijgcybilFZ+jqDQI+NpJI6eTo6vWkKeOvKJwf?=
 =?us-ascii?Q?aDHUoQXcsjvQKv3w+ZqtsA9i7Pq+m8pF5dhSu2HL5+ElxQexIQlescxAJ4JR?=
 =?us-ascii?Q?ueS95obk60v6+FGAW1oT83CJoUDV02OnePLGl2mDW86S/nDT2p6LGVflGuJq?=
 =?us-ascii?Q?Ppzaslp7YlTJYOFwUvfbEK1Iqfz3EjGxyHs/HHuOTUwgtTt36Pk52bLlF5eY?=
 =?us-ascii?Q?+BYAFn1q+ixHA8TAQ1rtghnMD5H2JBvOHmMq6k/TDUGUf4c9CuMp991lSOTT?=
 =?us-ascii?Q?MgyzjFwtib5WPA6l1ra/WKRrZNUMo0L8iqYXXljafs6CXf9DnRgmwp6HkppL?=
 =?us-ascii?Q?2KsGbdTHPy9jPfpwje/xfhjaEH0taoAMLlNjRmz9St1Onnbvgs6C5Gt0PDZy?=
 =?us-ascii?Q?FFaq3apib9szbSUirDolpnu+bYrRk3c1AhWy0/F21Q7V3b7AUARJqSKPzuPi?=
 =?us-ascii?Q?2CEGOQCPk3Sa8acUotfSNObnxcxLix1ClHSwXeVAhZ/75UOfN6YBdn542UWf?=
 =?us-ascii?Q?JQLo1Y/BbZS099YA7f2ap0VKfpcwXlm0Zbd0xKaMkeJKbwkcOuoxNpnf1t8n?=
 =?us-ascii?Q?B13gbXOnGMgjS3AddrSCTkEL3a69fMFOHiFjNg+b0Co4+6h1KjatPZMhgkvr?=
 =?us-ascii?Q?CjclU7+h72ZpMjPYVz3S6wQfQKMp2z8QO9XVWsUfFdd+ZMG9I6Su/rM44Xrn?=
 =?us-ascii?Q?KGfQaEXkfOSL2RDsWmp+U9P/z7PSsKRGKzkfh93psFGrkgzAmC8LyCaHQ/ve?=
 =?us-ascii?Q?H8ImbVIk7YZ0gX3qljCQJsZQoT/bANyAGUTt4uV+u3ERBGFCFwXMOxzODQL/?=
 =?us-ascii?Q?fVz7cvgCwtTQvJJWALtnlTRsjORiDDqpzutlFPDwEc5DNjvmYCFEKmCyqQvh?=
 =?us-ascii?Q?0sdnJjBrbqcmMMPMFXHVivL3GviFh7ASjo3ymezb4MCbO2nwkBoRDtgChNHw?=
 =?us-ascii?Q?BbP38V2Onw6EqUjEHFfK/MJBJgT04MvQwjiPUk533oy40frK5YOdPrtTN8LS?=
 =?us-ascii?Q?U2NBXttUGkVRagtuIqBV9ngBcqOIyZJjTI+xAD7vO45x3NMMDliZ+G2H4YNd?=
 =?us-ascii?Q?Q9f6hDQzr73NMHH5TB1/2ZFklDQljtsA3U3oY/yfqlRtn2zAlK8l7mI2TrXw?=
 =?us-ascii?Q?weysP5IOd/ZaQRclnsxFYHPoYcljG1RC7/xwwaIdNh5dyEx8g2kDiFuUwLgG?=
 =?us-ascii?Q?99ov8rlyCt6kwsILrblG7KbWuGU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1664f3-05c5-4420-99b2-08d9a384a2f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 13:27:11.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59o7P5oVlhTKxUtOOTgVQbBcl7V0VT4t3kqlDzMrDXXaD18YluqnCbAXwE45Awsy4QP2rtlgIZlSthCQ2KKPCnEwADSlQ6yWsxyoS+ceQYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=997 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090081
X-Proofpoint-GUID: Uz8iBlf-2KbqhZ34TlRmhpQE647aBsOk
X-Proofpoint-ORIG-GUID: Uz8iBlf-2KbqhZ34TlRmhpQE647aBsOk
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 09, 2021 at 04:21:37PM +0300, Dan Carpenter wrote:
> drivers/dma/dw-edma/dw-edma-pcie.c:192 dw_edma_pcie_probe() info: return a literal instead of 'err'
> 
> The idea of the Smatch check is that it's pretty easy to get "if (!ret)"
> and "if (ret)" transposed.  It would show up in testing, of course, but
> the truth is that maintainers don't always have all the hardware they
> maintain.
> 
> And the other idea is that "return 0;" is always more readable and
> intentional than "return ret;" where ret is zero.

So other style anti-patterns that this check finds are:

net/bluetooth/hci_sync.c
  4489  
  4490          err = hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
  4491                                    hdev->le_scan_window_discovery,
  4492                                    own_addr_type, filter_policy, filter_dup);
  4493          if (!err)
  4494                  return err;

2) Success handling.
3) Making the last check special/opposite.

*sad face*

  4495  
  4496  failed:
  4497          /* Resume advertising if it was paused */
  4498          if (use_ll_privacy(hdev))


regards,
dan carpenter
