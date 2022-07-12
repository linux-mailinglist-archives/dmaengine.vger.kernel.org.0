Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F2571354
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiGLHoB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiGLHn6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 03:43:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6E1658E;
        Tue, 12 Jul 2022 00:43:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C4s3XC018645;
        Tue, 12 Jul 2022 07:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sBZ86Oh7n4TOe8y7mvXePGxbkvyMJ69jCN4pokkXuBQ=;
 b=W+rzPUsum8bD6SpxeB5BjUj02FKhyB77utqQs2X3Ptwh1nyh3OAbPi3Aye3Ml9EUOsTi
 kMICsU9HV9rp9dT9uwAHNzCXoq0Uviq9Y7XPoKu5eqERTzSrCvHuk+rNsyl/1KDpM7dj
 V5o+vXaHOIYEaRSpz6l7Dw3LSSRdLg6m0jEebcXZ/+I9S4o7TdISPXB5eKV2DmsK1RVt
 YGy/gui5KWOd0aygMAJADQn9Cu+EXRfWhm5Ht0GuxBupmHOE9dlvZEZ+4LGMO+5sBUZG
 FMT1Ddrp8Wu7zIHNJ4EKYbHdR+HUtoUIjqoPROZdVj8WNT0THQ1SyJG/LRQe3ImDUxSO 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sdw9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 07:43:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C7fZ15019689;
        Tue, 12 Jul 2022 07:43:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70432bkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 07:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5V45/Rq7vO7nxudWC01EQiSdl4dVNcriUSwAXlStZthrkGaaQL5u/Z/Zia0LPr/FhL9ddQBAe2OugiAZrnbVaWTWI67/grgyg4l2ilY8QjVsiye5ALyCu1PORUJZzdwbLoZMNxcK4HeUHWAyNEsSbBra/eZLYhrXrUJTCUF9Wn1CwMPBLdkXHhh0BdQ9d8CMWRKjmmgKXrTl8smvpH/Gc5RaXrHfQLZm0O5gabt7/H3iDPPM1onZP6tQZFiA+wRDfkruBTsTvCwp5zO3sH3KAjXw0CLKNq9k9Q1/ERQh9XqNjeq0+cwxc3ziLXNY7PQ89ifvFWpppYp0i4b3ooncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBZ86Oh7n4TOe8y7mvXePGxbkvyMJ69jCN4pokkXuBQ=;
 b=fT+lpj6XEmBMbD0MFXrsT+c2Mf6TEQLQZhhaFJigRG1lfL5OYCfr/H63RKilMmsMSxiglucWOSFECxd0Huf1m/0kuF2J0p8j7+KmmI1zqCmSwseDlyHsNlXhUKJdsWjV6lkfLMUb325WiYDb62qImPKyMTeijTqvbIlU/CXXs+YAVb99r+4l02lSqMzhjF1MNJx5yYAdCRUbgSFvTUboYFq51N5kH16th+jLFf5vHIc8t7DqWGued+0ninxtN9tVd0btA9ixFVwxG+HoSID9CIrgtI08+xZ92RsraZWsdJRewJ0KcEF70bSuDXfUReOLd8JE1q0oK5lJfRDiC1wlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBZ86Oh7n4TOe8y7mvXePGxbkvyMJ69jCN4pokkXuBQ=;
 b=l7sXG0CNAy7s/4hXdyHtABE4f3Btsku/GPFfC4RlCowWOcWtg6Kw1sTTDvM0VP8HbxjIM+5gu85lb5lGACKNSU0rUrhj1GHEDa1r+c84/oGPKzHsJHGApk8WqRxTRSOH0+/4/el9LOblrEjW3RNrzoHK76o3F1niEQ700BC1r5U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 07:43:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:43:42 +0000
Date:   Tue, 12 Jul 2022 10:43:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: IS_ERR() vs NULL bug in
 pci_epf_test_init_dma_chan()
Message-ID: <20220712074316.GK2338@kadam>
References: <YsftwaVowtU9/pgn@kili>
 <CANXvt5rK98-cEMgpzopY9POOK8a5=VDib8uKPLgJakOG=hRfwQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5rK98-cEMgpzopY9POOK8a5=VDib8uKPLgJakOG=hRfwQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eaa9de8-3f04-459b-bc57-08da63da3da2
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8sUxhVZzHJNwsab7iMFcpvXyTU586Q/BtXhvsaSiDGC+lXIYxBpcxKeluKJvtiRPWICcKUZCv5qAUNOrj3Z7Yh8Sj/GsI8617i9wZ/6FlbwXAuWwwvEAuKShfBa2mr/jP5RQfhPpEWffBep4XFcpaZqPs3foG8zqnqOAbcCtONo3OCcsZhmvSW/+QxFjSsEx9XX3Jydgk0Unph0u42XYCVNV98MTvN83Bg42g2AQdvYZjjdchJiAmbQCY1p46C9K4FMMnAVKmjjASrpDzyvEXUcr5Ix/ztBQN6uuRRJxn6hpQCsTH463nPTsouKzKGes0DN5UoTGkbOlyzhtN58VRUpiKqK++dmXLpwYRifQcCfq9GqGogTqae2y53PcEgrmRdPs2uxKMzdzYrbIOEhd8urEci3Xn90P0CRlgR+w7hDvHqu7trw2fFWYGmz/SveoW8Bl5Y8JXOb5CO25fYHXX3B6B5WMLjjvXjWwpd9Qvpx2ol4lE1leaWQaMe64DGHfzQZJ+M1JWFrloVCROKNpO+HFSKBbbkutJzwHKENNArSkc8Cvl6xUzbXmn+IL5UNGNm/uvM2eZqDA3Sd3bDKJqfo6ED7w4PvKnaVvT5hHpY1qX9uY8R77nCa4kOIZ3pn3eePhrRz9xAwfkrhRaH3c9Q2ntPGT5XtrUD29ltAk2g9h/z3uzhEChteo+61ou0Vj8t3cp4IJYNZtKsHr05ukN20dvqzigr4UwrMPwhUJsVgDxyZpHq4Ae9a5hGTX44Y2NZcGPGrNugMDGUEl0HZTyYytRSC8w1Zufst7jRNDQVPEUXKpaRac1u4Vno3Lanl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(558084003)(6666004)(38100700002)(86362001)(6486002)(33656002)(33716001)(5660300002)(7416002)(8936002)(38350700002)(478600001)(316002)(9686003)(41300700001)(66556008)(2906002)(1076003)(54906003)(4326008)(6916009)(44832011)(66946007)(66476007)(26005)(6512007)(6506007)(8676002)(52116002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBxX8nlJ3JMu9Q5rOWMPoJAYGapuhWkF+E6rOR09CZo4nSuf9VApFOdcTbDx?=
 =?us-ascii?Q?PCKwk0MAyii/0BRukhHarhlbZOp3dJ1hsgSwWvU6BF/Z7IzAmsmTEuJkjpQC?=
 =?us-ascii?Q?Dz0sgQyDQtOINAgYsNOsP3PjOTzZk5imrI4UIURx6iuxvM0l61sx2Wo5Da3s?=
 =?us-ascii?Q?q7sd5kK9NDL00j1douN7NTz14cHk40UzqJ28gA3LRwD7KZr2Xye/VGswCu1c?=
 =?us-ascii?Q?RiofvlS7yr/qc/cnRzaSI49syR5QIPJ2XP3e4Z/TsxSuEKVwPIFZUlfOPVr8?=
 =?us-ascii?Q?JPrfy6r1W0G7IPHTwJ0fAyFcxIsM6VL0UWtIJyHy2w3TuLGkKaFpEXb3kwNG?=
 =?us-ascii?Q?R4m31Ym2g97wyxNvLavcR4FZjQu0weUH8/VOjLuov7aS4BnQumuN6SqVIn3U?=
 =?us-ascii?Q?jqBb4VBp5N8Hp03RBmZhM0R7FoUG1x6HX05Wpod3H9HgXZ7BQs0DfdKAQd1r?=
 =?us-ascii?Q?53SlukR+mT4+fkK0VFKSfVcNTy1JunM/LQnajZextxtuNGG7cGHuHakohFkT?=
 =?us-ascii?Q?e8RTAY+wjDZ2005YwNB2o7hDqpxENI6xIMCiaUP8ppqiKM3E8Kl04BhmuQjf?=
 =?us-ascii?Q?laDreWFHrmuFUV6mnG8xLn9KXiycHmBk58XaSepEZQrNMegskrBTSbefVYgi?=
 =?us-ascii?Q?kbyKsopEM9qjHkVy7FTe6YYOjNd1vpwqZOqnjQ/e6seWV8Q/8u0QAcZVoDEv?=
 =?us-ascii?Q?rFk0t3URYWCCbd/4eeWy5wOzx0hieYD/tff3VambYnQcJOMYR/9iDElReJ49?=
 =?us-ascii?Q?Jo47wZ4ZF8NVedEa6Hn20Eo26A/E8QOZWiaIkO7dAXX8xx9Zvs5DzATxT625?=
 =?us-ascii?Q?n1jZ+64TaSmDXtnbmNzph4yA+z2be5gNYyilXeQJUXIRjyIvqF44k20Gk2s1?=
 =?us-ascii?Q?YxE/X6JkoYE38QwmBpP/tHF9dQl/NrbzH9ZzT7kkcvUdYUx1ASuFq0TzgqyE?=
 =?us-ascii?Q?FOYYulb11l79phVE/4KXvo/FxC43WSfqsA7UqXnrZi0jcOIm9ewG7lEboRTM?=
 =?us-ascii?Q?icgdP7iuok0P3hTP3erIohY7bXz/qLtSEgZcFNcfm4BqVayBuioX1P4bsNN0?=
 =?us-ascii?Q?G9E8TF0sHiy50ciVjHXDpWty5cvo+7Yxsod8f84Y6WKHazUjfofY8b/5VYVn?=
 =?us-ascii?Q?qCkgP/9pR+SCrJ+8gn5S5BbxCUu3zHLe9ClLEHitKpEJy9gvXInzvp8uo5MI?=
 =?us-ascii?Q?b5cvuW1Ww6af/WkoBKIfZNR58tmKvXtNVfKp7TdW/ydMBj9urEAOAoJ1Jcd9?=
 =?us-ascii?Q?Va25ny10t2G7+oDSh50MHzjhWxLG0oqkNghdkJ6rW2xq7YLSKpS3AVFtLhaL?=
 =?us-ascii?Q?5tVmUUjxMs0QULpHwwgSenzsIo4PWuuJzOEZTjE6pica4PBHmFvWB58W04fn?=
 =?us-ascii?Q?mZtOVozMQwWcIwttq1+uFvV2OVZbtgHQoYk0Bibiqu9Sq2wUdfMk3Wyvopyk?=
 =?us-ascii?Q?wq2asRvC8/GPGtXbEZ/odnMg5R5EVlr/D+ePXHKb//7gRxQsI/9qnCoJd3Rl?=
 =?us-ascii?Q?fl1o4w+0BBBj4QtvEyiH7buJPzydS5WzyU8dg8ZTyuVAtcJ2jLgF5rf7232n?=
 =?us-ascii?Q?pypWqRT1PQsOqfD+vEnU0cWqtsHjTn6si1yyEPNR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa9de8-3f04-459b-bc57-08da63da3da2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 07:43:41.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JMnJ41OBIpSwm05oK8mGL3sAMI2VZNjS6ah0IcTmzFMNOpB79wuAOBo86BWymwLu+XklRp1zxdevXNH4FQ5LuebV4fd6VFcMrl/EKyqBU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=861 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120031
X-Proofpoint-ORIG-GUID: 9QPkdz6EUohUDb7D7Zb6kt2jf6h8vm_9
X-Proofpoint-GUID: 9QPkdz6EUohUDb7D7Zb6kt2jf6h8vm_9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 11, 2022 at 02:50:14PM +0900, Shunsuke Mie wrote:
> This patch changes for a tx dma channel. There is a similar problem for a
>  rx one too. The code doesn't cause an error, but it is likely better to
> change to just NULL checking.
> 

Yep.  Thanks.  I will resend.

regards,
dan carpenter

