Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2912635829A
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHMAf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 08:00:35 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:63521
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231295AbhDHMAe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Apr 2021 08:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRP09ID75ZI82Byk4nnqp9knH4qgVKVsw+dltJvZsCb5UX2wztCtBXy1HZjgg4Hgf+KkOGp1h5p4HFJmeone0go0EmcsuMCHhDomFuawagDq/dsZRvYfva6hqIQohJ38UMKDYCSlSesTTGBrFSow2Kd3HQoXP9GNfOw7Qa1oKuX+gNP67eshPAr75cYBbLeL7zZDUtkUAKOFAq3ivzN8QUEAzUK+KyKbxHb35Uz3vts0c/e/7O2zPLLU9Ixs1sYDzgAtF8TgrWP/q1/8hmaK/699JxqQqlHd8H90wltCRWNErziGIhLStKSM+bX7hHmeZeQawSOUWoQ5zJc00ayQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vqTczvgFY1z191Mtp9pXfKNIQC+e8f/ufFWo1CXsPY=;
 b=Gjx7kt2qRcSxxTQcEtSLHZ5xtaMLAGtHmFaSdz0iwTWyFuZiSe5IaeJ0UQXqivgbcK9kBdPvnpVQ+9plPDb10e5Qjd0IBS9rRpLktT80nHkJJCZzgJtrmSS75YE9ynosh/S7i+wp3zIAxymMHxjSQjIu1FyRYC3z3sck8AnmA1I7LqXYMVQiH3b2MbWNNGCjhdf/fLZTj3HO0R/jVrVsMvbvOHvvOj73RzzZk9cTYxDgt1FqbxjKZHnSISAyV0F9uA+Z251o51a8mE37gdg/O82nR+oz0sQP1Ji7lv4pY8pjhig3+cQAMzrBe6kSWkTjmWgxFYTGOmFfeifNVeZuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vqTczvgFY1z191Mtp9pXfKNIQC+e8f/ufFWo1CXsPY=;
 b=d/7Wl4hcd7kcLFpZ2fRsrWJNBzABtujcDuR+clmuNJZrUFro1mswsjGbej6buNCvYwyw37Dgp10GPCZqK0qL17mYWmaFy7kY6YMXJTuuflvaZTPUz1bnZFfDCXYiwfUsA88CXLgeYk6dsNHS/w1COP3EkVhkEr0Bgi5jXGo5V6qxJpJk1FNseZYXXbl66Tq5MfevftNOqb0dXOZDVhokdHe2YPk7owSbAU/z32nDNhdt1d4nNNMbrQyE3JLnzBOXSya1+7KQcm8fap6Na8TBTKtN8dloobCvhWhu0pZqaUxXnsuhb/PQ2hNglyojB29fNb59QE1a5K1o0ONb3zI46Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 12:00:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:00:22 +0000
Date:   Thu, 8 Apr 2021 09:00:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v9 00/11] idxd 'struct device' lifetime handling fixes
Message-ID: <20210408120020.GP7405@nvidia.com>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
 <8ba1ad4c-c6da-a511-91ae-b02a374965db@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba1ad4c-c6da-a511-91ae-b02a374965db@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Thu, 8 Apr 2021 12:00:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUTKe-002hIb-L9; Thu, 08 Apr 2021 09:00:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bbd8c8-b3f9-4515-0e8d-08d8fa85e2f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301899C0B9DE628F4008DF27C2749@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMUDi+dfD+o6r9BCtXvlR/8vUmIiJcw+jcnIH5ikMBlKmkseXGqcKERL6rU395N+Xr/YfjANuqsjQ4ktmNtPqeq2ipMr9apmWJa0Ry3RftnKTgRgkKeTO46uv3KtvUzSEQGmlRfz97TlqQpZ+Xc7d2iRdqtUgYHLoioZzPgb6V0g4uQJIGezXrCBtyNeo9AFkq85+H6d0WiOCvTrePNVhnrqAOO54BNF3AxAdN/Bbmwa7XOf3VJtMHsWL4c4ZrG/ovgyaiJYpreLEdH5g3uxa+iPB8Kf+nLd4AIJq6orL+p34cHYVXbazOvlWWC6t0t5UZPjD1z8IndnA4MMiWwipzZdKRasNoinULwj5afNx60GsF49Z2iVr8mIDZ5pTQJbWgfezyHTgZFEySl+gZriwaCGpWUvfGDnYFTXQ5x2KN5k0oxyVTcVVo2M2/TQT3CDeMDN+pfvFhINGANmPQwKgEc5jc62v7dLFjlSs0IL+SEwpoORH71I44crfd0cRAEgPoMjGl1WGwUZnYClDyr6Od4Kw+0AMGrlUTudn/j1rCvPm5Z2t9VZMsSSOiJHQEo5uzQSxq6WjsAmLAh7zWCLQq0k24eUbtIkK/s1GRW6dGeJ9ae6M1uu23gpPHmIUVs838TqevqQj7u3HnyL7+SK+D+7OlFcrl9Q91jd2tcg1xQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(2616005)(38100700001)(33656002)(66946007)(4744005)(26005)(83380400001)(5660300002)(54906003)(66556008)(66476007)(1076003)(36756003)(2906002)(426003)(86362001)(8936002)(4326008)(478600001)(186003)(8676002)(9786002)(9746002)(6916009)(316002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W0puHhbXmlaYsijMh5+Ogc4ME5Rc0hjfaSZ/uT1i41z7f7OheYyWAyaySpyc?=
 =?us-ascii?Q?x9F2OJvufvBdFywtgInyBOkibMqCwJqJepGSeVu+hrEUXSm8zszZ0a+KsFv0?=
 =?us-ascii?Q?EIUDt8WZTzTtWKnYmuPSAevTylY50kCnG+YdV73vwrBrgurvxh+ivKXJCn0J?=
 =?us-ascii?Q?PIMA+xdSFKPtp0vEYhFwASZRv7L/WaEoZvr4lKDUTHTtujw3OUBCn9JL124S?=
 =?us-ascii?Q?6w7eBKqxGNZZZ7ANOIFMSMoJ+kCRFcbRCgAz29sio2orOQeqKFBtqXQQxOVF?=
 =?us-ascii?Q?rD747vNJma/22FsVGrbc5gaVR07WI9MqtdRnM2Y1CvytBBaaJmnh0kltmOeP?=
 =?us-ascii?Q?PsqnuKMsi02zxvefQVD0S3uwUTtMDGtDqlc43RgX6njqPhJXvsNhDgbGdiMT?=
 =?us-ascii?Q?zcUPxaALHaR3khLBdicBT2WiUXXrnRsfuHZ7VUFw/F6AtHVi2MFGLHPgQ04I?=
 =?us-ascii?Q?cNJgF3ixVaX2wUZmz1Wk/gYzdii6+Ig/RCPGJgj3x+vsg886Xf0hOPXuhVoV?=
 =?us-ascii?Q?j9dQjX3glKzRlYqaqsnElGiHN33q1tDpC+AkmKBldv6ave5rY6OVqbPpQ3Lg?=
 =?us-ascii?Q?LF7oDiyT73niV54PI9DLW66WLoe70T1hHsK3+wWC4JQp9upy6GsagMfTp95g?=
 =?us-ascii?Q?6/YZUKx9fPql8+vF7dJlqOALN8ahATHZ+84sTFO/vPDBH36iGpBjJyf0cLHL?=
 =?us-ascii?Q?ZWu8LpR0iiSqvF8sziB73B0Y2J31dU+pDB8lSqrmWzhv/9VRfDHmjZh5rpRV?=
 =?us-ascii?Q?t3OpCawbtob1OwaKzT/LcoPhHCuP8Q4rJseJA9RTcVD6m5EXbnvv3hzIWcxZ?=
 =?us-ascii?Q?KshpKKXUdo2i6OkzB2dcUUUlhu9x00aL3VzOuKQ7VS7mjFbtdELRI43nqZf1?=
 =?us-ascii?Q?WoHesdZOWJMhvyS+M7TnPHzEacnfu7piADBP05PX53Yjn5sE8bwMiVC3jlL9?=
 =?us-ascii?Q?hcXHtY9atJA72rfCHzKT6gc5rgx9PpCLy2xrrfeIhsxQ9TdpKx+rRoxrPDOT?=
 =?us-ascii?Q?y/DFfRvLebWzEQXv5I8nv3fGJQnvjPyMhu8NoSgvjgqYY2DEmjoHELzTMz53?=
 =?us-ascii?Q?cd1IqqarnKB2Rt2Q1WtkKOhwlor+vPWzxV4M4dU+bwUL0I84VcffOHWCFli7?=
 =?us-ascii?Q?PW2nvnIYzi48F653DYGeUnWZWHpKGFUVzIY0GPeoRNNWo0arM5DQV7nWBxGv?=
 =?us-ascii?Q?qMm1R0da10UZZXMuXQbLga7353sXj/13GZ/P7sgXkqe4kDN4z+x+E7F+wAdf?=
 =?us-ascii?Q?B4UGAmJ/Ud6f3ZY/P9AH+poTqyUoYD6GEVnh6m5pYifaBx0l5yG233vsuBGq?=
 =?us-ascii?Q?/tbzjOFPZ641sWZLeU9TmwulDkijet4hrgWrTa6jY/WF+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bbd8c8-b3f9-4515-0e8d-08d8fa85e2f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:00:21.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Izj8YqYvOXcovBaILfXVYfLBLrf2ouIZOolYHNi0/0w8//WKCJNtwf4PlSFFj6Qz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 07, 2021 at 05:00:21PM -0700, Dave Jiang wrote:
> 
> On 4/2/2021 12:56 PM, Dave Jiang wrote:
> > v9:
> > - Fill in details for commit messages (Jason)
> > - Fix wrong indentation (Jason)
> > - Move stray change to the right patch (Jason)
> > - Remove idxd_free() and refactor 'struct device' setup so we can use
> >    ->release() calls to clean up. (Jason)
> > - Change idr to ida. (Jason)
> > - Remove static type detection for each device type (Dan)
> 
> Hi Jason, thanks for all your reviews. Do you have any additional comments
> with this series? I'd like this series to be accepted by Vinod for 5.12-rc
> if possible. Thanks!

It is probably way to big for a -rc6 kernel.

Nothing stands out as making this worse, so I have no objection to
Vinod taking it, but I didn't look to see if there are more things
that need attention.

Jason
